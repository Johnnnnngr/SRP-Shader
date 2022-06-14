#ifndef CUSTOM_CARTOON_LIGHT_INCLUDED
#define CUSTOM_CARTOON_LIGHT_INCLUDED

float3 IncomingLight (Surface surface, Light light)
{
    float s  =dot(normalize(surface.normal),normalize(light.direction));
    if (s >= surface.firstedge )
    {
        return light.color;
    }
    else if(s <= surface.firstedge && s >= surface.secondedge)
    {
        return light.color*0.6;
    }
    else{
        return light.color*0.1;
    }
    //return saturate(dot(surface.normal, light.direction))*light.color;
}

float3 GetLightings (Surface surface,CartoonBRDF brdf, Light light) {
	return IncomingLight(surface, light) * DirectBRDF(surface, brdf, light);
}

float3 GetLighting (Surface surface, CartoonBRDF brdf) {
    float3 color = 0.0;
    for (int i = 0; i<GetDirectionalLightCount(); i++)
    {
        color += GetLightings(surface, brdf, GetDirectionalLight(i));
    }
	return color;
}


#endif