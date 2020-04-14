// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "FireSight"
{
	Properties
	{
		_Texture0("Texture 0", 2D) = "white" {}
		_Noise1speed("Noise 1 speed", Float) = 0.5
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_Noise1Scale("Noise 1 Scale ", Float) = 0.5
		_Noise2Scale("Noise 2 Scale ", Float) = 0.5
		_Noise2speed("Noise 2 speed", Float) = 0.5
		_InnerFlameStep("Inner Flame Step", Range( 0.5 , 1)) = 0
		_OpacityStep("Opacity Step", Range( 0.5 , 1)) = 0
		_OuterColorBlend("OuterColorBlend", Range( 0.5 , 1)) = 0
		_Color2("Color 2", Color) = (0,0,0,0)
		_Color1("Color 1", Color) = (1,0.995283,0.995283,0)
		_Color0("Color 0", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color0;
		uniform float _InnerFlameStep;
		uniform sampler2D _Texture0;
		uniform float _Noise1speed;
		uniform float _Noise1Scale;
		uniform float _Noise2speed;
		uniform float _Noise2Scale;
		uniform sampler2D _TextureSample2;
		uniform float4 _TextureSample2_ST;
		uniform float _OpacityStep;
		uniform float4 _Color1;
		uniform float _OuterColorBlend;
		uniform float4 _Color2;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 appendResult34 = (float4(0.0 , _Noise1speed , 0.0 , 0.0));
			float2 panner31 = ( 1.0 * _Time.y * appendResult34.xy + ( _Noise1Scale * i.uv_texcoord ));
			float4 appendResult33 = (float4(0.0 , _Noise2speed , 0.0 , 0.0));
			float2 panner32 = ( 1.0 * _Time.y * appendResult33.xy + ( i.uv_texcoord * _Noise2Scale ));
			float2 uv_TextureSample2 = i.uv_texcoord * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
			float4 tex2DNode41 = tex2D( _TextureSample2, uv_TextureSample2 );
			float temp_output_3_0 = step( _InnerFlameStep , ( ( ( tex2D( _Texture0, panner31 ).r * tex2D( _Texture0, panner32 ).r ) * tex2DNode41.r ) + tex2DNode41.r ) );
			float smoothstepResult17 = smoothstep( 0.0 , _OuterColorBlend , i.uv_texcoord.y);
			float4 temp_output_7_0 = ( ( _Color0 * temp_output_3_0 ) + ( ( temp_output_3_0 - step( ( ( ( tex2D( _Texture0, panner31 ).r * tex2D( _Texture0, panner32 ).r ) * tex2DNode41.r ) + tex2DNode41.r ) , _OpacityStep ) ) * ( ( _Color1 * ( 1.0 - smoothstepResult17 ) ) + ( smoothstepResult17 * _Color2 ) ) ) );
			o.Albedo = temp_output_7_0.rgb;
			o.Emission = temp_output_7_0.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17700
0;36;2560;1343;1310.333;705.8387;1.925686;True;True
Node;AmplifyShaderEditor.RangedFloatNode;26;-2624.944,704.9051;Inherit;False;Property;_Noise2speed;Noise 2 speed;5;0;Create;True;0;0;False;0;0.5;-1.6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-2624.944,608.9051;Inherit;False;Property;_Noise2Scale;Noise 2 Scale ;4;0;Create;True;0;0;False;0;0.5;4.69;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-2647.444,356.4048;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;24;-2612.444,198.4048;Inherit;False;Property;_Noise1Scale;Noise 1 Scale ;3;0;Create;True;0;0;False;0;0.5;-2.45;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-2607.444,103.4048;Inherit;False;Property;_Noise1speed;Noise 1 speed;1;0;Create;True;0;0;False;0;0.5;0.91;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;33;-2309.445,770.4051;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-2228.445,271.4048;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-2228.445,528.4051;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;34;-2292.445,62.40481;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PannerNode;32;-1980.445,633.4051;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;31;-2012.445,156.4048;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;35;-1980.445,384.2265;Inherit;True;Property;_Texture0;Texture 0;0;0;Create;True;0;0;False;0;7c9a11611c112174691fa953ff8eb2a1;7c9a11611c112174691fa953ff8eb2a1;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;38;-1680.446,171.0482;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;39;-1696.446,504.3275;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-1355.713,315.4427;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;41;-1428.139,716.4564;Inherit;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;False;0;-1;53c553bc524f2af45b5663e63bad281f;53c553bc524f2af45b5663e63bad281f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-1068.713,357.5511;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-518.8713,1056.072;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-566.406,1194.607;Inherit;False;Property;_OuterColorBlend;OuterColorBlend;8;0;Create;True;0;0;False;0;0;1;0.5;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;17;-233.8713,1171.072;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;42;-764.4136,358.0509;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;20;-511.8713,1335.072;Inherit;False;Property;_Color2;Color 2;9;0;Create;True;0;0;False;0;0,0,0,0;0.4245283,0.4245283,0.4245283,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-426.8713,659.0721;Inherit;False;Property;_OpacityStep;Opacity Step;7;0;Create;True;0;0;False;0;0;0.774;0.5;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;95.12866,826.0721;Inherit;False;Property;_Color1;Color 1;10;0;Create;True;0;0;False;0;1,0.995283,0.995283,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;-436.8713,227.0721;Inherit;False;Property;_InnerFlameStep;Inner Flame Step;6;0;Create;True;0;0;False;0;0;0.692;0.5;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;8;-426.8713,424.0721;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;18;52.12866,1121.072;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;3;-31.87134,304.0721;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;373.1287,1052.072;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;44.12866,1272.072;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;14;-39.87134,626.0721;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;580.1287,1115.072;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;6;208.1287,407.0721;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;81.59393,-31.99739;Inherit;False;Property;_Color0;Color 0;11;0;Create;True;0;0;False;0;0,0,0,0;0.6406793,0.8018868,0.04917233,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;665.1287,278.0721;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;668.1287,490.0721;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;1075.884,371.7802;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1485.407,315.8324;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;FireSight;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;33;1;26;0
WireConnection;29;0;24;0
WireConnection;29;1;25;0
WireConnection;28;0;25;0
WireConnection;28;1;27;0
WireConnection;34;1;23;0
WireConnection;32;0;28;0
WireConnection;32;2;33;0
WireConnection;31;0;29;0
WireConnection;31;2;34;0
WireConnection;38;0;35;0
WireConnection;38;1;31;0
WireConnection;39;0;35;0
WireConnection;39;1;32;0
WireConnection;40;0;38;1
WireConnection;40;1;39;1
WireConnection;43;0;40;0
WireConnection;43;1;41;1
WireConnection;17;0;15;2
WireConnection;17;2;16;0
WireConnection;42;0;43;0
WireConnection;42;1;41;1
WireConnection;8;0;42;0
WireConnection;18;0;17;0
WireConnection;3;0;11;0
WireConnection;3;1;8;0
WireConnection;22;0;2;0
WireConnection;22;1;18;0
WireConnection;19;0;17;0
WireConnection;19;1;20;0
WireConnection;14;0;8;0
WireConnection;14;1;12;0
WireConnection;21;0;22;0
WireConnection;21;1;19;0
WireConnection;6;0;3;0
WireConnection;6;1;14;0
WireConnection;4;0;1;0
WireConnection;4;1;3;0
WireConnection;5;0;6;0
WireConnection;5;1;21;0
WireConnection;7;0;4;0
WireConnection;7;1;5;0
WireConnection;0;0;7;0
WireConnection;0;2;7;0
ASEEND*/
//CHKSM=F10821AEA1430B062C4D1E23490C4B9E5923561B