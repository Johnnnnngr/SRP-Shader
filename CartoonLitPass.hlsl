#ifndef CUSTOM_LIT_PASS_INCLUDED
#define CUSTOM_LIT_PASS_INCLUDED
#include "Assets/CustomRenderPipeline/ShaderLibrary/Common.hlsl"
#include "Assets/CustomRenderPipeline/ShaderLibrary/CartoonSurface.hlsl"
#include "Assets/CustomRenderPipeline/ShaderLibrary/Light.hlsl"
#include "Assets/CustomRenderPipeline/ShaderLibrary/CartoonBRDF.hlsl"
#include "Assets/CustomRenderPipeline/ShaderLibrary/CartoonLighting.hlsl"


TEXTURE2D(_BaseMap);
SAMPLER(sampler_BaseMap);

UNITY_INSTANCING_BUFFER_START(UnityPerMaterial)
    UNITY_DEFINE_INSTANCED_PROP(float4, _BaseMap_ST)
    UNITY_DEFINE_INSTANCED_PROP(float4,_BaseColor)
    UNITY_DEFINE_INSTANCED_PROP(float, _Cutoff)
    UNITY_DEFINE_INSTANCED_PROP(float, _Metallic)
    UNITY_DEFINE_INSTANCED_PROP(float, _Smoothness)


    UNITY_DEFINE_INSTANCED_PROP(float, _FirstEdge)
    UNITY_DEFINE_INSTANCED_PROP(float, _SecondEdge)
UNITY_INSTANCING_BUFFER_END(UnityPerMaterial)



struct Attributes
{
    float3 positionOS:Position;
    float2 baseUV : TEXCOORD0;
    float3 normalOS:NORMAL;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};
struct Varying
{
    float4 positionCS:SV_POSITION;
    float3 positionWS:VAR_POSITION;
    float2 baseUV : VAR_BASE_UV;
    float3 normalWS: VAR_NORMAL;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};


Varying LitPassVertex(Attributes input){
    Varying output;
    UNITY_SETUP_INSTANCE_ID(input);
    UNITY_TRANSFER_INSTANCE_ID(input,output);
    output.positionWS = TransformObjectToWorld(input.positionOS.xyz);
    float3 normalWS = normalize(TransformObjectToWorldNormal(input.normalOS));
    output.positionCS = TransformWorldToHClip(output.positionWS);
    output.normalWS = TransformObjectToWorldNormal(input.normalOS);
    float4 baseST = UNITY_ACCESS_INSTANCED_PROP(UnityPerMaterial, _BaseMap_ST);
    output.baseUV = input.baseUV *baseST.xy + baseST.zw;
    return output;
}

float4 LitPassFragment(Varying input):SV_TARGET{
    Surface surface;


    UNITY_SETUP_INSTANCE_ID(input);
    float4 baseMap = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, input.baseUV);
    float4 baseColor = UNITY_ACCESS_INSTANCED_PROP(UnityPerMaterial, _BaseColor);
    float4 base = baseMap * baseColor;
    #if defined(_CLIPPING)
    clip(base.a - UNITY_ACCESS_INSTANCED_PROP(UnityPerMaterial, _Cutoff));
    #endif
    surface.normal = normalize(input.normalWS);
    surface.color = base.rgb;
    surface.alpha = base.a;
    surface.metallic = UNITY_ACCESS_INSTANCED_PROP(UnityPerMaterial, _Metallic);
	surface.smoothness = UNITY_ACCESS_INSTANCED_PROP(UnityPerMaterial, _Smoothness);
    surface.viewDirection = normalize(_WorldSpaceCameraPos - input.positionWS);
    surface.firstedge = UNITY_ACCESS_INSTANCED_PROP(UnityPerMaterial, _FirstEdge);
    surface.secondedge = UNITY_ACCESS_INSTANCED_PROP(UnityPerMaterial, _SecondEdge);
    #if defined(_PREMULTIPLY_ALPHA)
		CartoonBRDF brdf = GetBRDF(surface, true);
    #else 
        CartoonBRDF brdf = GetBRDF(surface);
    #endif
    float3 color = GetLighting(surface, brdf);

    return float4(color, surface.alpha);
}

#endif