Shader "Custom/Opaque"
{
    Properties{
        _BaseColor("BaseColor", Color) = (0.5,0.5,0.5,1)
        _BaseMap("Texture", 2D) = "white"{}
        _Metallic("Metallic", Range(0,1)) = 0.5
        _Smoothness("Smoothness", Range(0,1)) = 1
        [Toggle(_PREMULTIPLY_ALPHA)] _PremulAlpha ("Premultiply Alpha", Float) = 0

    }
    SubShader{
        Pass{
            Tags{"LightMode" = "CustomLit"}

            HLSLPROGRAM
            #pragma target 3.5
            #pragma vertex LitPassVertex
            #pragma fragment LitPassFragment
            #pragma multi_compile_instancing
            #pragma shader_feature _CLIPPING
            #pragma shader_feature _PREMULTIPLY_ALPHA
            #include "Assets/CustomRenderPipeline/Shader/LitPass.hlsl"
            
            
            ENDHLSL
        }
    }
}