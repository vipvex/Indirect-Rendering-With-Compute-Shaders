#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED

    // Current Animation
    float f_current = _Time.y / _AnimationLengths[ _AnimationProperties[unity_InstanceID].currentAnimIndex ];
    fmod(f_current, 1.0);
    float current_animMap_x = (vid + 0.5) * animsTexelWidth;
    float current_animMap_y = f_current + _AnimationProperties[unity_InstanceID].animOffset;
    
    float2 currentUv = float2(current_animMap_x, current_animMap_y);
    float4 currentPos = SAMPLE_TEXTURE2D_ARRAY(_AnimationTextures, sampler_AnimationTextures, currentUv, 0);

    // Old animation
    float f_old = _Time.y / _AnimationLengths[ _AnimationProperties[unity_InstanceID].oldAnimIndex ];
    fmod(f_old, 1.0);
    float old_animMap_x = (vid + 0.5) * animsTexelWidth;
    float old_animMap_y = f_old + _AnimationProperties[unity_InstanceID].animOffset;

    float2 oldUv = float2(old_animMap_x, old_animMap_y);
    float4 oldPos = currentPos; // SAMPLE_TEXTURE2D_ARRAY(_AnimationTextures, sampler_AnimationTextures, oldUv, 0);

    // Blend animations
    float4 f = (currentPos * _AnimationProperties[unity_InstanceID].currentAnimAmount) + (oldPos * _AnimationProperties[unity_InstanceID].oldAnimAmount); 
    f /= 2; 

    return f;

#else

    return float4(0, 0, 0, 0);

#endif

TEXTURE2D_ARRAY( _AnimationTextures );
uniform SAMPLER( sampler_AnimationTextures );


#define UNITY_ARGS_TEX2DARRAY(tex) Texture2DArray tex, SamplerState sampler##tex
#define UNITY_PASS_TEX2DARRAY(tex) tex, sampler##tex

// TEXTURE2D_ARRAY( _AnimationTextures ); 			uniform SAMPLER( sampler_AnimationTextures );

#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED

    // Current Animation
    float f_current = _Time.y / _AnimationLengths[ _AnimationProperties[unity_InstanceID].currentAnimIndex ];
    fmod(f_current, 1.0);
    float current_animMap_x = (vid + 0.5) * animsTexelWidth;
    float current_animMap_y = f_current + _AnimationProperties[unity_InstanceID].animOffset;

    return float2(current_animMap_x, current_animMap_x);



    // Old animation
    float f_old = _Time.y / _AnimationLengths[ _AnimationProperties[unity_InstanceID].oldAnimIndex ];
    fmod(f_old, 1.0);
    float old_animMap_x = (vid + 0.5) * animsTexelWidth;
    float old_animMap_y = f_old + _AnimationProperties[unity_InstanceID].animOffset;




    // Sample
    float4 currentPos = UNITY_SAMPLE_TEX2DARRAY(animTextures, float3(current_animMap_x, current_animMap_y, _AnimationProperties[unity_InstanceID].currentAnimIndex));

    //
    float4 oldPos = UNITY_SAMPLE_TEX2DARRAY(animTextures, float3(old_animMap_x, old_animMap_y, _AnimationProperties[unity_InstanceID].oldAnimIndex));



#else

    return float4(0, 0, 0, 0);

#endif



// Current Pos
float f_current = _Time.y / _AnimationLengths[ _AnimationProperties[unity_InstanceID].currentAnimIndex ];
fmod(f_current, 1.0);
float current_animMap_x = (vid + 0.5) * animsTexelWidth;
float current_animMap_y = f_current + _AnimationProperties[unity_InstanceID].animOffset;

// Curent Anim Index


// Blend
float4 f = (currentPos * _AnimationProperties[unity_InstanceID].currentAnimAmount) + (oldPos * _AnimationProperties[unity_InstanceID].oldAnimAmount); 
f /= 2; 

return f;


// 
#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED

    // Current Animation
    float f_current = _Time.y / 1;
    fmod(f_current, 1.0);
    float current_animMap_x = (vid + 0.5) * animsTexelWidth;
    float current_animMap_y = f_current + _AnimationProperties[unity_InstanceID].animOffset;

    return float2(current_animMap_x, current_animMap_y);

 #else

     return float2(0, 0);

 #endif