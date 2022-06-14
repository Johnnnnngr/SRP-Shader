#ifndef CUSTOM_CartoonBRDF_INCLUDED
#define CUSTOM_CartoonBRDF_INCLUDED



struct CartoonBRDF {
    float3 diffuse;

};

CartoonBRDF GetBRDF (Surface surface)
{
    CartoonBRDF brdf;


    brdf.diffuse = surface.color;
    return brdf;
}



float3 DirectBRDF (Surface surface, CartoonBRDF brdf, Light light) {
	return brdf.diffuse;
}
#endif