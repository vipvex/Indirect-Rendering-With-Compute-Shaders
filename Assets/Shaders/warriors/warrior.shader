// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "warrior"
{
	Properties
	{
		_Base("Base", 2D) = "white" {}
		_Texture0("Texture 0", 2DArray) = "white" {}
		_AnimationIndex1("AnimationIndex1", Range( 0 , 3)) = 0
		_AnimationIndex2("AnimationIndex2", Range( 0 , 3)) = 0
		_AnimTime("AnimTime", Range( 0 , 1.5)) = 0
		_AnimationBlend("AnimationBlend", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.5
		#pragma multi_compile_instancing
		uniform uint _ArgsOffset;                 StructuredBuffer<uint> _ArgsBuffer;                 StructuredBuffer<Indirect2x2Matrix> _InstancesDrawMatrixRows01;                 StructuredBuffer<Indirect2x2Matrix> _InstancesDrawMatrixRows23;                 StructuredBuffer<Indirect2x2Matrix> _InstancesDrawMatrixRows45;                                  void setup()                 {                     #if defined(SHADER_API_METAL)                         uint index = unity_InstanceID;                     #else                         uint index = unity_InstanceID + _ArgsBuffer[_ArgsOffset];                     #endif                                          Indirect2x2Matrix rows01 = _InstancesDrawMatrixRows01[index];                     Indirect2x2Matrix rows23 = _InstancesDrawMatrixRows23[index];                     Indirect2x2Matrix rows45 = _InstancesDrawMatrixRows45[index];                                          unity_ObjectToWorld = float4x4(rows01.row0, rows01.row1, rows23.row0, float4(0, 0, 0, 1));                     unity_WorldToObject = float4x4(rows23.row1, rows45.row0, rows45.row1, float4(0, 0, 0, 1));                 }
		#include "Assets/Shaders/warriors/ProceduralInstancing.hlsl"
		#pragma multi_compile_instancing
		#pragma instancing_options procedural:setup
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 

		struct appdata_full_custom
		{
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float4 texcoord : TEXCOORD0;
			float4 texcoord1 : TEXCOORD1;
			float4 texcoord2 : TEXCOORD2;
			float4 texcoord3 : TEXCOORD3;
			fixed4 color : COLOR;
			UNITY_VERTEX_INPUT_INSTANCE_ID
			uint ase_vertexId : SV_VertexID;
		};
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform UNITY_DECLARE_TEX2DARRAY( _Texture0 );
		float4 _Texture0_TexelSize;
		uniform float _AnimTime;
		uniform float _AnimationIndex1;
		uniform float _AnimationIndex2;
		uniform float _AnimationBlend;
		uniform sampler2D _Base;
		uniform float4 _Base_ST;

		void vertexDataFunc( inout appdata_full_custom v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float temp_output_161_0 = ( ( v.ase_vertexId + 0.5 ) * _Texture0_TexelSize.x );
			float2 appendResult175 = (float2(temp_output_161_0 , _AnimTime));
			float4 texArray169 = UNITY_SAMPLE_TEX2DARRAY_LOD(_Texture0, float3(appendResult175, _AnimationIndex1), 0.0 );
			float2 appendResult164 = (float2(temp_output_161_0 , _AnimTime));
			float4 texArray167 = UNITY_SAMPLE_TEX2DARRAY_LOD(_Texture0, float3(appendResult164, _AnimationIndex2), 0.0 );
			float4 lerpResult171 = lerp( texArray169 , texArray167 , _AnimationBlend);
			v.vertex.xyz = lerpResult171.rgb;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Base = i.uv_texcoord * _Base_ST.xy + _Base_ST.zw;
			o.Albedo = tex2D( _Base, uv_Base ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18100
0;73;1241;649;865.2191;-629.9496;1.3;True;True
Node;AmplifyShaderEditor.TexturePropertyNode;162;-1607.127,1104.06;Inherit;True;Property;_Texture0;Texture 0;18;0;Create;True;0;0;False;0;False;cfba82ae997cc2647aa9b0d4b1baa6fd;cfba82ae997cc2647aa9b0d4b1baa6fd;False;white;Auto;Texture2DArray;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;158;-1131.156,1441.094;Inherit;False;Constant;_Float4;Float 4;19;0;Create;True;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexIdVariableNode;157;-1129.778,1312.94;Inherit;False;0;1;INT;0
Node;AmplifyShaderEditor.TexelSizeNode;159;-1132.741,1571.889;Inherit;False;-1;1;0;SAMPLER2D;;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;160;-899.6533,1348.768;Inherit;False;2;2;0;INT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;168;-742.1349,1495.311;Inherit;False;Property;_AnimTime;AnimTime;25;0;Create;True;0;0;False;0;False;0;0;0;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;161;-665.3957,1374.949;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;166;-347.2576,1497.943;Inherit;False;Constant;_MipLevel;MipLevel;19;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;164;-330.9084,1663.915;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;175;-324.164,1333.646;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;116;-3486.69,908.8076;Inherit;False;1577.584;3077.227;Method 2;8;37;65;123;47;148;48;144;153;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;165;-633.0911,1178.681;Inherit;False;Property;_AnimationIndex1;AnimationIndex1;23;0;Create;True;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;173;-591.4945,1832.261;Inherit;False;Property;_AnimationIndex2;AnimationIndex2;24;0;Create;True;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;117;-4488.576,-740.3356;Inherit;False;1102.525;970.8361;Method 1;4;88;104;122;120;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureArrayNode;169;-20.26184,1096.084;Inherit;True;Property;_Animation1;Animation1;19;0;Create;True;0;0;False;0;False;None;0;Object;-1;MipLevel;False;7;6;SAMPLER2D;;False;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;123;-3385.314,2219.571;Inherit;False;629.8073;458.41;Walking Animation;3;126;125;124;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;148;-3408.126,3333.65;Inherit;False;629.8073;458.41;Walking Animation;3;151;150;149;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;127;-1238.783,-151.0731;Inherit;False;1026.801;468.6694;Example;5;141;128;139;130;143;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;47;-3400.188,1661.749;Inherit;False;629.8073;458.41;Walking Animation;3;46;44;45;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureArrayNode;167;-2.597433,1631.075;Inherit;True;Property;_Animation2;Animation2;20;0;Create;True;0;0;False;0;False;None;0;Object;-1;MipLevel;False;7;6;SAMPLER2D;;False;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;48;-3405.482,1122.648;Inherit;False;679.2069;420.7102;Idle Animation;3;31;40;29;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;115;-3244.225,-446.1737;Inherit;False;1676.024;833.9615;Method 3;11;106;87;108;109;112;105;89;76;107;113;90;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;172;204.3466,1495.878;Inherit;False;Property;_AnimationBlend;AnimationBlend;26;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;144;-3403.966,2743.708;Inherit;False;629.8073;458.41;Walking Animation;3;146;145;147;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TexelSizeNode;125;-2975.504,2465.979;Inherit;False;-1;1;0;SAMPLER2D;;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;107;-1858.458,15.0787;Inherit;False;#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED$$float4 f = (currentPos * _AnimationProperties[unity_InstanceID].currentAnimAmount) + (oldPos * _AnimationProperties[unity_InstanceID].oldAnimAmount)@ $f /= 2@ $$return f@$$ #else$$     return float4(0, 0, 0, 0)@$$ #endif;0;False;2;True;currentPos;FLOAT4;0,0,0,0;In;;Inherit;False;True;oldPos;FLOAT4;0,0,0,0;In;;Inherit;False;Blend;False;False;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;174;-350.5296,2277.131;Inherit;False;Constant;_MipLevel1;MipLevel;19;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureArrayNode;87;-2329.272,41.62766;Inherit;True;Property;_Animations;Animations;3;0;Create;True;0;0;False;0;False;None;0;Instance;120;Auto;False;7;6;SAMPLER2D;;False;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexIdVariableNode;88;-4360.7,-684.4709;Inherit;False;0;1;INT;0
Node;AmplifyShaderEditor.CustomExpressionNode;105;-2652.054,-388.4642;Inherit;False;// $#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED$$    // Current Animation$    float f_current = _Time.y / 1@$    fmod(f_current, 1.0)@$    float current_animMap_x = (vid + 0.5) * animsTexelWidth@$    float current_animMap_y = f_current + _AnimationProperties[unity_InstanceID].animOffset@$$    return float2(current_animMap_x, current_animMap_y)@$$ #else$$     return float2(0, 0)@$$ #endif;2;False;2;False;vid;FLOAT;0;In;;Inherit;False;False;animsTexelWidth;FLOAT;0;In;;Inherit;False;Current Pos;False;False;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;139;-877.6813,-33.86103;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexelSizeNode;46;-2990.377,1908.156;Inherit;False;-1;1;0;SAMPLER2D;;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;154;59.47775,-87.33213;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;177;-307.519,1407.35;Inherit;False;Property;_Animationindex3;Animationindex2;21;0;Create;True;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexIdVariableNode;130;-1129.423,-52.4481;Inherit;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;122;-4436.523,-139.0228;Inherit;False;Constant;_Index;Index;7;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;113;-2754.081,292.2813;Inherit;False;Constant;_Float3;Float 3;6;0;Create;True;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;152;-1973.154,1754.29;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;155;-464.5394,-272.6971;Inherit;False;Property;_Float5;Float 5;17;0;Create;True;0;0;False;0;False;5;100;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;143;-1204.573,41.17691;Inherit;False;Property;_time;time;15;0;Create;True;0;0;False;0;False;0;0;0;1.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;153;-2253.411,1534.274;Inherit;False;Property;_MeshSize;Mesh Size;16;0;Create;True;0;0;False;0;False;5;3;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureArrayNode;120;-4213.847,-192.1399;Inherit;True;Property;_AnimationTextures;Animation Textures;13;0;Create;True;0;0;False;0;False;None;0;Object;-1;Auto;False;7;6;SAMPLER2D;;False;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;149;-3358.124,3503.823;Inherit;True;Property;_HitTexture;Hit Texture;5;0;Create;True;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;109;-3176.237,-158.3412;Inherit;False;Constant;_Float1;Float 1;6;0;Create;True;0;0;False;0;False;8192;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexIdVariableNode;108;-3155.855,-337.7662;Inherit;False;0;1;INT;0
Node;AmplifyShaderEditor.TexturePropertyNode;45;-3350.186,1831.921;Inherit;True;Property;_WalkingTexture;Walking Texture;2;0;Create;True;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;124;-3335.312,2389.744;Inherit;True;Property;_RunningTexture;Running Texture;3;0;Create;True;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureArrayNode;76;-2265.266,-325.4924;Inherit;True;Property;_AnimationsArray;Animations Array;11;0;Create;True;0;0;False;0;False;None;0;Object;-1;Auto;False;7;6;SAMPLER2D;;False;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;25;192.3603,726.9066;Inherit;True;Property;_Base;Base;0;0;Create;True;0;0;False;0;False;-1;e599ad2d07d640a49945ec695caacac0;e599ad2d07d640a49945ec695caacac0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;104;-4293.791,-511.4718;Inherit;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;False;8192;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;126;-3304.87,2305.878;Inherit;False;Property;_RunningLength;Running Length;8;0;Create;True;0;0;False;0;False;1;0.6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;90;-2744.763,185.1816;Inherit;False;#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED$$return _AnimationProperties[unity_InstanceID].oldAnimIndex@$$ #else$$     return 0@$$ #endif;0;False;0;Old Anim Index;False;False;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-3319.742,1748.055;Inherit;False;Property;_WalkingLength;Walking Length;7;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;106;-2743.517,53.27731;Inherit;False;#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED$$    float f_old = _Time.y / _AnimationLengths[ _AnimationProperties[unity_InstanceID].oldAnimIndex ]@$    fmod(f_old, 1.0)@$    float old_animMap_x = (vid + 0.5) * animsTexelWidth@$    float old_animMap_y = f_old + _AnimationProperties[unity_InstanceID].animOffset@$$     return float2(old_animMap_x, old_animMap_x)@$$ #else$$     return float2(0, 0)@$$ #endif;2;False;2;True;vid;FLOAT;0;In;;Inherit;False;True;animsTexelWidth;FLOAT;0;In;;Inherit;False;Old Pos;False;False;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;145;-3353.964,2915.182;Inherit;True;Property;_AttackingTexture;Attacking Texture;4;0;Create;True;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;146;-3323.523,2830.016;Inherit;False;Property;_AttackingLength;Attacking Length;9;0;Create;True;0;0;False;0;False;1;1.12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;112;-2601.86,-137.3934;Inherit;False;Constant;_Float2;Float 2;6;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-3349.363,1172.648;Inherit;False;Property;_IdleLength;IdleLength;6;0;Create;True;0;0;False;0;False;1;1.967;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;178;-614.319,1442.45;Inherit;False;Property;_Animationindex4;Animationindex2;22;0;Create;True;0;0;False;0;False;0;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexIdVariableNode;65;-2401.96,1655.51;Inherit;False;0;1;INT;0
Node;AmplifyShaderEditor.LerpOp;171;691.2784,1400.098;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;31;-3355.483,1269.42;Inherit;True;Property;_IdleTexture;Idle Texture;1;0;Create;True;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.CustomExpressionNode;89;-2611.852,-238.7686;Inherit;False;#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED$$return _AnimationProperties[unity_InstanceID].currentAnimIndex@$$ #else$$     return 0@$$ #endif;0;False;0;Current Anim Index;False;False;0;0;1;INT;0
Node;AmplifyShaderEditor.TexelSizeNode;29;-2971.966,1319.27;Inherit;True;-1;1;0;SAMPLER2D;;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;37;-2220.82,1896.423;Inherit;False;#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED$$    // Idle$    float f_idle = _Time.y / idleLength@$    fmod(f_idle, 1.0)@$    float idle_animMap_x = (vid + 0.5) * idle_texel.x@$    float idle_animMap_y = f_idle + _Properties[unity_InstanceID].animOffset@$    float4 idlePos = tex2Dlod(idleMap, float4(idle_animMap_x, idle_animMap_y, 0, 0))@$$    // walk$    float f_walk = _Time.y / walkLength@$    fmod(f_walk, 1.0)@$    float walk_animMap_x = (vid + 0.5) * walk_texel.x@$    float walk_animMap_y = f_walk@$    float4 walkPos = tex2Dlod(walkMap, float4(walk_animMap_x, walk_animMap_y, 0, 0))@$$    // run$    float f_run = _Time.y / runLength@$    fmod(f_run, 1.0)@$    float run_animMap_x = (vid + 0.5) * run_texel.x@$    float run_animMap_y = f_run@$    float4 runPos = tex2Dlod(runMap, float4(run_animMap_x, run_animMap_y, 0, 0))@$$    // attacking$    float f_attack = _Time.y / attackLength@$    fmod(f_attack, 1.0)@$    float attack_animMap_x = (vid + 0.5) * attack_texel.x@$    float attack_animMap_y = f_attack@$    float4 attackPos = tex2Dlod(attackMap, float4(attack_animMap_x, attack_animMap_y, 0, 0))@$$    // being hit$    float f_hit = _Time.y / hitLength@$    fmod(f_hit, 1.0)@$    float hit_animMap_x = (vid + 0.5) * hit_texel.x@$    float hit_animMap_y = f_hit@$    float4 hitPos = tex2Dlod(hitMap, float4(hit_animMap_x, hit_animMap_y, 0, 0))@$$$    // Blend animations$    float4 f = (idlePos * _Properties[unity_InstanceID].idleAmount) + (walkPos * _Properties[unity_InstanceID].walkingAmount) + (runPos * _Properties[unity_InstanceID].runningAmount) +(attackPos * _Properties[unity_InstanceID].attackingAmount) + (hitPos * _Properties[unity_InstanceID].beingHitAmount)@ $$    f /= 5@ $$return f@$$#else$$    float f_idle = _Time.y / idleLength@$    fmod(f_idle, 1.0)@$    float idle_animMap_x = (vid + 0.5) * idle_texel.x@$    float idle_animMap_y = f_idle + animOffset@$    float4 idlePos = tex2Dlod(idleMap, float4(idle_animMap_x, idle_animMap_y, 0, 0))@$    return idlePos @$$#endif$;4;False;17;False;vid;INT;0;In;;Inherit;False;False;animOffset;FLOAT;0;In;;Inherit;False;False;idleLength;FLOAT;0;In;;Inherit;False;False;idleMap;SAMPLER2D;0,0,0,0;In;;Inherit;False;False;idle_texel;FLOAT4;0,0,0,0;In;;Inherit;False;False;walkLength;FLOAT;0;In;;Inherit;False;False;walkMap;SAMPLER2D;_Sampler737;In;;Inherit;False;False;walk_texel;FLOAT4;0,0,0,0;In;;Inherit;False;False;runLength;FLOAT;0;In;;Inherit;False;False;runMap;SAMPLER2D;;In;;Inherit;False;False;run_texel;FLOAT4;0,0,0,0;In;;Inherit;False;False;attackLength;FLOAT;0;In;;Inherit;False;False;attackMap;SAMPLER2D;;In;;Inherit;False;False;attack_texel;FLOAT4;0,0,0,0;In;;Inherit;False;False;hitLength;FLOAT;0;In;;Inherit;False;False;hitMap;SAMPLER2D;;In;;Inherit;False;False;hit_texel;FLOAT4;1,0,0,0;In;;Inherit;False;Vertex Animation;False;False;0;17;0;INT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;SAMPLER2D;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT;0;False;6;SAMPLER2D;_Sampler737;False;7;FLOAT4;0,0,0,0;False;8;FLOAT;0;False;9;SAMPLER2D;;False;10;FLOAT4;0,0,0,0;False;11;FLOAT;0;False;12;SAMPLER2D;;False;13;FLOAT4;0,0,0,0;False;14;FLOAT;0;False;15;SAMPLER2D;;False;16;FLOAT4;1,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexelSizeNode;151;-2998.317,3580.058;Inherit;False;-1;1;0;SAMPLER2D;;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;150;-3327.682,3419.957;Inherit;False;Property;_HitLength;Hit Length;10;0;Create;True;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexelSizeNode;147;-2992.77,2922.343;Inherit;False;-1;1;0;SAMPLER2D;;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureArrayNode;128;-560.7956,23.19696;Inherit;True;Property;_TextureArray0;Texture Array 0;12;0;Create;True;0;0;False;0;False;None;0;Object;-1;Auto;False;7;6;SAMPLER2D;;False;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;141;-860.2769,154.3829;Inherit;False;Property;_index;index;14;0;Create;True;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;176;1534.989,1389.032;Float;False;True;-1;3;ASEMaterialInspector;0;0;Standard;warrior;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Absolute;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;4;Custom;uniform uint _ArgsOffset@                 StructuredBuffer<uint> _ArgsBuffer@                 StructuredBuffer<Indirect2x2Matrix> _InstancesDrawMatrixRows01@                 StructuredBuffer<Indirect2x2Matrix> _InstancesDrawMatrixRows23@                 StructuredBuffer<Indirect2x2Matrix> _InstancesDrawMatrixRows45@                                  void setup()                 {                     #if defined(SHADER_API_METAL)                         uint index = unity_InstanceID@                     #else                         uint index = unity_InstanceID + _ArgsBuffer[_ArgsOffset]@                     #endif                                          Indirect2x2Matrix rows01 = _InstancesDrawMatrixRows01[index]@                     Indirect2x2Matrix rows23 = _InstancesDrawMatrixRows23[index]@                     Indirect2x2Matrix rows45 = _InstancesDrawMatrixRows45[index]@                                          unity_ObjectToWorld = float4x4(rows01.row0, rows01.row1, rows23.row0, float4(0, 0, 0, 1))@                     unity_WorldToObject = float4x4(rows23.row1, rows45.row0, rows45.row1, float4(0, 0, 0, 1))@                 };False;;Custom;Include;ProceduralInstancing.hlsl;True;28abce27c59133b4880337c7dd29a245;Custom;Pragma;multi_compile_instancing;False;;Custom;Pragma;instancing_options procedural:setup;False;;Custom;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;159;0;162;0
WireConnection;160;0;157;0
WireConnection;160;1;158;0
WireConnection;161;0;160;0
WireConnection;161;1;159;1
WireConnection;164;0;161;0
WireConnection;164;1;168;0
WireConnection;175;0;161;0
WireConnection;175;1;168;0
WireConnection;169;6;162;0
WireConnection;169;0;175;0
WireConnection;169;1;165;0
WireConnection;169;2;166;0
WireConnection;167;6;162;0
WireConnection;167;0;164;0
WireConnection;167;1;173;0
WireConnection;167;2;166;0
WireConnection;125;0;124;0
WireConnection;107;1;87;0
WireConnection;87;0;106;0
WireConnection;87;1;113;0
WireConnection;105;0;108;0
WireConnection;105;1;109;0
WireConnection;139;0;130;0
WireConnection;139;1;143;0
WireConnection;46;0;45;0
WireConnection;154;0;155;0
WireConnection;154;1;128;0
WireConnection;152;0;153;0
WireConnection;152;1;37;0
WireConnection;120;1;122;0
WireConnection;76;0;105;0
WireConnection;76;1;112;0
WireConnection;106;0;108;0
WireConnection;106;1;109;0
WireConnection;171;0;169;0
WireConnection;171;1;167;0
WireConnection;171;2;172;0
WireConnection;29;0;31;0
WireConnection;37;0;65;0
WireConnection;37;2;40;0
WireConnection;37;3;31;0
WireConnection;37;4;29;0
WireConnection;37;5;44;0
WireConnection;37;6;45;0
WireConnection;37;7;46;0
WireConnection;37;8;126;0
WireConnection;37;9;124;0
WireConnection;37;10;125;0
WireConnection;37;11;146;0
WireConnection;37;12;145;0
WireConnection;37;13;147;0
WireConnection;37;14;150;0
WireConnection;37;15;149;0
WireConnection;37;16;151;0
WireConnection;151;0;149;0
WireConnection;147;0;145;0
WireConnection;128;0;139;0
WireConnection;128;1;141;0
WireConnection;176;0;25;0
WireConnection;176;11;171;0
ASEEND*/
//CHKSM=4C8C067659B6406E62514D7D08C39A9102C32164