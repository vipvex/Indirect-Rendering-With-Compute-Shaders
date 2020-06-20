
// // Idle
// float f_idle = _Time.y / idleLength;
// fmod(f_idle, 1.0);
// float idle_animMap_x = (vid + 0.5) * idle_texel.x;
// float idle_animMap_y = f_idle + animOffset;
// float4 idlePos = tex2Dlod(idleMap, float4(idle_animMap_x, idle_animMap_y, 0, 0));

// // walk
// float f_walk = _Time.y / walkLength;
// fmod(f_walk, 1.0);
// float walk_animMap_x = (vid + 0.5) * walk_texel.x;
// float walk_animMap_y = f_walk + animOffset;
// float4 walkPos = tex2Dlod(walkMap, float4(walk_animMap_x, walk_animMap_y, 0, 0));

// // Blend animations
// float4 f = (idlePos * idleAmount) + (walkPos * walkAmount); 
// f /= 2; 

// return f;


// StructuredBuffer<MeshProperties> _Properties;

// v2f vert(appdata_t i, uint instanceID: SV_InstanceID) {
//     v2f o;

//     float4 pos = mul(_Properties[instanceID].mat, i.vertex);
//     o.vertex = UnityObjectToClipPos(pos);
//     o.color = _Properties[instanceID].color;

//     return o;
// }


// StructuredBuffer<MeshProperties> _Properties;
// float4 pos = mul(_Properties[instanceID].mat, i.vertex);
// return pos;


Shader "Custom/ads"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
