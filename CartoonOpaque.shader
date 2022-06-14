Shader "Custom/CartoonOpaque"
{
    Properties{
        _BaseColor("BaseColor", Color) = (0.5,0.5,0.5,1)
        _BaseMap("Texture", 2D) = "white"{}
        _FirstEdge("First Edge", Range(-1,1))= 0.707
        _SecondEdge("Second Edge", Range(-1,1))= 0
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
            #include "Assets/CustomRenderPipeline/Shader/CartoonLitPass.hlsl"
            
            
            ENDHLSL
        }
    }
}