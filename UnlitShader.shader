Shader "Custom/Unlit"
{
    Properties{
        _BaseColor("BaseColor", Color) = (1,1,1,1)
    }
    SubShader{
        Pass{
            HLSLPROGRAM
            #pragma vertex UnlitPassVertex
            #pragma fragment UnlitPassFragment
            #pragma multi_compile_instancing
            #include "Assets/CustomRenderPipeline/Shader/UnlitPass.hlsl"
            
            
            ENDHLSL
        }
    }
}