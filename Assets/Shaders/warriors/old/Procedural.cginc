
#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED


// Texture array
// Animation lengths float array
// animation offset

// Current animation texture
// Old animation texture

// Current animation texel width
// old animation texel width

// Current animation amount
// Old animation amount


// Idle
float f_idle = _Time.y / idleLength;
fmod(f_idle, 1.0);
float idle_animMap_x = (vid + 0.5) * idle_texel.x;
float idle_animMap_y = f_idle + animOffset;
float4 idlePos = tex2Dlod(idleMap, float4(idle_animMap_x, idle_animMap_y, 0, 0));

// walk
float f_walk = _Time.y / walkLength;
fmod(f_walk, 1.0);
float walk_animMap_x = (vid + 0.5) * walk_texel.x;
float walk_animMap_y = f_walk + animOffset;
float4 walkPos = tex2Dlod(walkMap, float4(walk_animMap_x, walk_animMap_y, 0, 0));


// Blend animations
float4 f = (idlePos * _Properties[unity_InstanceID].idleAmount) + (walkPos * _Properties[unity_InstanceID].walkingAmount); 
f /= 2; 


return f;

#else

float f_idle = _Time.y / idleLength;
fmod(f_idle, 1.0);
float idle_animMap_x = (vid + 0.5) * idle_texel.x;
float idle_animMap_y = f_idle + animOffset;
float4 idlePos = tex2Dlod(idleMap, float4(idle_animMap_x, idle_animMap_y, 0, 0));
return idlePos ;

#endif



