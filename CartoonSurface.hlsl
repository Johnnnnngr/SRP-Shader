#ifndef CUSTOM__CARTOON_SURFACE_INCLUDED
#define CUSTOM_CARTOON_SURFACE_INCLUDED

struct Surface {
    float3 normal;
    float3 color;
    float alpha;
    float metallic;
    float smoothness;
    float3 viewDirection;
    float firstedge;
    float secondedge;
};

#endif