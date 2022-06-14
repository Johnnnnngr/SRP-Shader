using UnityEngine.Rendering;
using UnityEngine;

public class CustomRenderPipeline : RenderPipeline
{
    CameraRenderer renderer = new CameraRenderer();
    bool useDynamicBatching, useGPUInstancing;
    public CustomRenderPipeline(bool useDynamicBatching, bool useGPUInstancing, bool useSRPBatching) {
        this.useDynamicBatching = useDynamicBatching;
        this.useGPUInstancing = useGPUInstancing;
        GraphicsSettings.useScriptableRenderPipelineBatching = useSRPBatching;
        GraphicsSettings.lightsUseLinearIntensity = true;
        }
    protected override void Render(ScriptableRenderContext ScriptableRenderContext, Camera[] cameras)
    {

        foreach (Camera camera in cameras)
        {
            renderer.Render(ScriptableRenderContext , camera, useDynamicBatching, useGPUInstancing);
        }
    }
}
