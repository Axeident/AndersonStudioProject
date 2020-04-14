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
		[Toggle]_MovingGRadient("Moving GRadient", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Overlay"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _Contrast;
		uniform float4 _TopColor;
		uniform float4 _BottomColor;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _MovingGRadient;
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
			float3 ase_worldPos = i.worldPos;
			float eyeDepth62 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, float4( ase_worldPos , 0.0 ).xy ));
			float3 temp_cast_1 = (( ase_vertex4Pos.y * abs( ( eyeDepth62 - ase_worldPos.z ) ) )).xxx;
			float3 temp_cast_2 = ((( _MovingGRadient )?( cos( ( _Gradientposition + _Time.y ) ) ):( _Gradientposition ))).xxx;
			float3 temp_cast_3 = (_Gradientsize).xxx;
			float4 lerpResult3 = lerp( _TopColor , _BottomColor , pow( ( distance( max( ( abs( ( temp_cast_1 - temp_cast_2 ) ) - ( temp_cast_3 * float3( 0.5,0.5,0.5 ) ) ) , float3( 0,0,0 ) ) , float3( 0,0,0 ) ) / _Gradientintensity ) , 0.5 ));
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
0;40;2560;1337;1367.995;-246.9961;1;True;True
Node;AmplifyShaderEditor.WorldPosInputsNode;66;-909.9417,710.5171;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ScreenDepthNode;62;-659.5411,426.3405;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;73;-757.8186,1363.221;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-619.8,740.0135;Float;False;Property;_Gradientposition;Gradient position;4;0;Create;True;0;0;False;0;1;1.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;63;-411.8714,463.4911;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;71;-224.5726,1258.057;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;64;-227.0437,534.4948;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;7;-720.8356,159.8263;Inherit;True;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CosOpNode;72;-6.75322,1266.893;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-185.9561,816.1252;Float;False;Property;_Gradientsize;Gradient size;3;0;Create;True;0;0;False;0;0.82;1.59;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;51.98724,325.2153;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-190.9514,907.0726;Float;False;Property;_Gradientintensity;Gradient intensity;5;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;74;-189.995,1066.996;Inherit;False;Property;_MovingGRadient;Moving GRadient;7;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;11;236.8408,663.0703;Inherit;True;BoxMask;-1;;3;9dce4093ad5a42b4aa255f0153c4f209;0;4;1;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;10;FLOAT3;0,0,0;False;17;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;197.1625,1133.681;Float;False;Constant;_devider;devider;0;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;121.8,-134.1;Float;False;Property;_TopColor;Top Color;1;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2;115.8,62.89994;Float;False;Property;_BottomColor;Bottom Color;2;0;Create;True;0;0;False;0;0,0,0,0;0.4716981,0.2462152,0.2113741,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;6;724.0706,937.5309;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;3;1033.861,232.4249;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;57;1634.325,1022.827;Float;False;Property;_Contrast;Contrast;6;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;56;2096.198,885.3891;Inherit;True;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;61;2467.939,882.679;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Color Blend;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Overlay;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;62;0;66;0
WireConnection;63;0;62;0
WireConnection;63;1;66;3
WireConnection;71;0;14;0
WireConnection;71;1;73;2
WireConnection;64;0;63;0
WireConnection;72;0;71;0
WireConnection;65;0;7;2
WireConnection;65;1;64;0
WireConnection;74;0;14;0
WireConnection;74;1;72;0
WireConnection;11;1;65;0
WireConnection;11;4;74;0
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
//CHKSM=A667022DC7872A797C8ED37DE3EB8A9B9AC31337