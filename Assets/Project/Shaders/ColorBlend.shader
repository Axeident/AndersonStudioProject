// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Color Blend"
{
	Properties
	{
		_TopColor("Top Color", Color) = (1,1,1,0)
		_BottomColor("Bottom Color", Color) = (0,0,0,0)
		_Gradientsize("Gradient size", Float) = 0.82
		_Gradientposition("Gradient position", Float) = 1
		_Gradientintensity("Gradient intensity", Float) = 1
		_Contrast("Contrast", Float) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Overlay"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
			float4 screenPos;
		};

		uniform float _Contrast;
		uniform float4 _TopColor;
		uniform float4 _BottomColor;
		uniform float _Gradientposition;
		uniform float _Gradientsize;
		uniform float _Gradientintensity;


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float3 temp_cast_0 = (( ase_vertex4Pos.y * ase_screenPosNorm.y )).xxx;
			float3 temp_cast_1 = (_Gradientposition).xxx;
			float3 temp_cast_2 = (_Gradientsize).xxx;
			float4 lerpResult3 = lerp( _TopColor , _BottomColor , pow( ( distance( max( ( abs( ( temp_cast_0 - temp_cast_1 ) ) - ( temp_cast_2 * float3( 0.5,0.5,0.5 ) ) ) , float3( 0,0,0 ) ) , float3( 0,0,0 ) ) / _Gradientintensity ) , 0.5 ));
			o.Albedo = CalculateContrast(_Contrast,lerpResult3).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17700
0;23;1317;817;-1568.798;-682.4084;1.010001;True;False
Node;AmplifyShaderEditor.ScreenPosInputsNode;59;-378.2674,538.7068;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;7;-391.125,348.6747;Inherit;True;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-190.9514,907.0726;Float;False;Property;_Gradientintensity;Gradient intensity;5;0;Create;True;0;0;False;0;1;3.51;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-185.9561,816.1252;Float;False;Property;_Gradientsize;Gradient size;3;0;Create;True;0;0;False;0;0.82;3.65;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-162.8,682.0135;Float;False;Property;_Gradientposition;Gradient position;4;0;Create;True;0;0;False;0;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;-14.26956,514.3099;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;197.1625,1133.681;Float;False;Constant;_devider;devider;0;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;11;236.8408,663.0703;Inherit;True;BoxMask;-1;;3;9dce4093ad5a42b4aa255f0153c4f209;0;4;1;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;10;FLOAT3;0,0,0;False;17;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;147,228;Float;False;Property;_BottomColor;Bottom Color;2;0;Create;True;0;0;False;0;0,0,0,0;0.4656898,0.08276967,0.5660378,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1;153,31;Float;False;Property;_TopColor;Top Color;1;0;Create;True;0;0;False;0;1,1,1,0;0.1013261,0.3162012,0.6509434,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;6;724.0706,937.5309;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;1634.325,1022.827;Float;False;Property;_Contrast;Contrast;6;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;3;647.7623,121.9248;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;56;2096.198,885.3891;Inherit;True;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;61;2467.939,882.679;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Color Blend;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;Overlay;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;60;0;7;2
WireConnection;60;1;59;2
WireConnection;11;1;60;0
WireConnection;11;4;14;0
WireConnection;11;10;12;0
WireConnection;11;17;13;0
WireConnection;6;0;11;0
WireConnection;6;1;5;0
WireConnection;3;0;1;0
WireConnection;3;1;2;0
WireConnection;3;2;6;0
WireConnection;56;1;3;0
WireConnection;56;0;57;0
WireConnection;61;0;56;0
ASEEND*/
//CHKSM=E4615BC0A19317E3740F232DAE59AFE1B61ED030