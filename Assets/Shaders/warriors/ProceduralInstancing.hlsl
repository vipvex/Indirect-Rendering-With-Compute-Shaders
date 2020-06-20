#ifndef PROCEDURAL_INSTANCING_INCLUDED
#define PROCEDURAL_INSTANCING_INCLUDED

#if defined( unity_ObjectToWorld )
	#undef unity_ObjectToWorld
#endif

#if defined( unity_WorldToObject )
	#undef unity_WorldToObject
#endif

#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED
	uniform float _NaN;
#else
	#define unity_ObjectToWorld UNITY_MATRIX_M
	#define unity_WorldToObject UNITY_MATRIX_I_M
#endif

void setup()
{
	#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED
		float4x4 data = _Properties[ unity_InstanceID ].mat;
		
		unity_ObjectToWorld = data;

		// unity_ObjectToWorld._11_21_31_41 = float4( data.w, 0, 0, 0 );
		// unity_ObjectToWorld._12_22_32_42 = float4( 0, data.w, 0, 0 );
		// unity_ObjectToWorld._13_23_33_43 = float4( 0, 0, data.w, 0 );
		// unity_ObjectToWorld._14_24_34_44 = float4( data.xyz, 1 );

		// unity_ObjectToWorld = mul(unity_ObjectToWorld, rotateX)

		unity_WorldToObject = unity_ObjectToWorld;
		// unity_WorldToObject._14_24_34 *= -1;
		// unity_WorldToObject._11_22_33 = 1.0f / unity_WorldToObject._11_22_33;	

		// unity_ObjectToWorld._11_21_31_41 = float4( data.w, 0, 0, 0 );
		// unity_ObjectToWorld._12_22_32_42 = float4( 0, data.w, 0, 0 );
		// unity_ObjectToWorld._13_23_33_43 = float4( 0, 0, data.w, 0 );
		// unity_ObjectToWorld._14_24_34_44 = float4( data.xyz, 1 );

		// unity_ObjectToWorld = mul(unity_ObjectToWorld, rotateX)

		// unity_WorldToObject = unity_ObjectToWorld;
		// unity_WorldToObject._14_24_34 *= -1;
		// unity_WorldToObject._11_22_33 = 1.0f / unity_WorldToObject._11_22_33;	
	#endif
}

// Can I just make a vertex shader right here?
// Or I need a way of accessing StructuredBuffer info in the sahder graph.

#endif // PROCEDURAL_INSTANCING_INCLUDED