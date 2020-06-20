#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED

    // Idle
    float f_idle = _Time.y / idleLength;
    fmod(f_idle, 1.0);
    float idle_animMap_x = (vid + 0.5) * idle_texel.x;
    float idle_animMap_y = f_idle + _Properties[unity_InstanceID].animOffset;
    float4 idlePos = tex2Dlod(idleMap, float4(idle_animMap_x, idle_animMap_y, 0, 0));

    // walk
    float f_walk = _Time.y / walkLength;
    fmod(f_walk, 1.0);
    float walk_animMap_x = (vid + 0.5) * walk_texel.x;
    float walk_animMap_y = f_walk;
    float4 walkPos = tex2Dlod(walkMap, float4(walk_animMap_x, walk_animMap_y, 0, 0));

    // run
    float f_run = _Time.y / runLength;
    fmod(f_run, 1.0);
    float run_animMap_x = (vid + 0.5) * run_texel.x;
    float run_animMap_y = f_run;
    float4 runPos = tex2Dlod(runMap, float4(run_animMap_x, run_animMap_y, 0, 0));

    // attacking
    float f_attack = _Time.y / attackLength;
    fmod(f_attack, 1.0);
    float attack_animMap_x = (vid + 0.5) * attack_texel.x;
    float attack_animMap_y = f_attack;
    float4 attackPos = tex2Dlod(attackMap, float4(attack_animMap_x, attack_animMap_y, 0, 0));

    // being hit
    float f_hit = _Time.y / hitLength;
    fmod(f_hit, 1.0);
    float hit_animMap_x = (vid + 0.5) * hit_texel.x;
    float hit_animMap_y = f_hit;
    float4 hitPos = tex2Dlod(hitMap, float4(hit_animMap_x, hit_animMap_y, 0, 0));


    // Blend animations
    float4 f = (idlePos * _Properties[unity_InstanceID].idleAmount) + (walkPos * _Properties[unity_InstanceID].walkingAmount) + (runPos * _Properties[unity_InstanceID].runningAmount) +(attackPos * _Properties[unity_InstanceID].attackingAmount) + (hitPos * _Properties[unity_InstanceID].beingHitAmount); 

    f /= 5; 

return f;

#else

    float f_idle = _Time.y / idleLength;
    fmod(f_idle, 1.0);
    float idle_animMap_x = (vid + 0.5) * idle_texel.x;
    float idle_animMap_y = f_idle + animOffset;
    float4 idlePos = tex2Dlod(idleMap, float4(idle_animMap_x, idle_animMap_y, 0, 0));
    return idlePos ;

#endif
