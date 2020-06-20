float _AnimationLengths[10];

struct AnimationProperties {  
    float4x4  mat;   		
    float animOffset;
    
    int currentAnimIndex;
    int oldAnimIndex;

    float currentAnimAmount;
    float oldAnimAmount;
};  	

StructuredBuffer<AnimationProperties> _AnimationProperties;
