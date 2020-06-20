struct MeshProperties {       
    float4x4  mat;

    float idleAmount;
    float walkingAmount;
    float runningAmount;
    float attackingAmount;
    float beingHitAmount;
    float animOffset;
};

StructuredBuffer<MeshProperties> _Properties;
