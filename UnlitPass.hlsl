#ifndef CUSTOM_UNLIT_PASS_INCLUDED
#define CUSTOM_UNLIT_PASS_INCLUDED
#include "Assets/CustomRenderPipeline/ShaderLibrary/Common.hlsl"



UNITY_INSTANCING_BUFFER_START(UnityPerMaterial)
    UNITY_DEFINE_INSTANCED_PROP(float4,_BaseColor)
UNITY_INSTANCING_BUFFER_END(UnityPerMaterial)



struct Attributes
{
    float3 positionOS:Position;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};
struct Varying
{
    float4 positionCS:SV_POSITION;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};


Varying UnlitPassVertex(Attributes input){
    Varying output;
    UNITY_SETUP_INSTANCE_ID(input);
    UNITY_TRANSFER_INSTANCE_ID(input,output);
    float3 positionWS = TransformObjectToWorld(input.positionOS.xyz);

    output.positionCS = TransformWorldToHClip(positionWS);

    return output;
}

float4 UnlitPassFragment(Varying input):SV_TARGET{
    UNITY_SETUP_INSTANCE_ID(input);
    return UNITY_ACCESS_INSTANCED_PROP(UnityPerMaterial, _BaseColor);
}

#endif