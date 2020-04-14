// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TreeShader"
{
	Properties
	{
		_TopColor("Top Color", Color) = (1,1,1,0)
		_WorldFrequency("WorldFrequency", Range( 0 , 1)) = 0.07497557
		_winddirection("wind direction", Range( 0 , 6.25)) = 0.2205882
		_Blendamount("Blendamount", Range( 0 , 1)) = 0.001
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		_BottomColor("Bottom Color", Color) = (0,0,0,0)
		_Gradientsize("Gradient size", Float) = 0.82
		_Gradientposition("Gradient position", Float) = 1
		[Toggle]_MovingGRadient("Moving GRadient", Float) = 0
		_Gradientintensity("Gradient intensity", Float) = 1
		_Contrast("Contrast", Float) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _winddirection;
		uniform float _WorldFrequency;
		uniform float _Blendamount;
		uniform float3 _Vector0;
		uniform float _Contrast;
		uniform float4 _TopColor;
		uniform float4 _BottomColor;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _MovingGRadient;
		uniform float _Gradientposition;
		uniform float _Gradientsize;
		uniform float _Gradientintensity;


		float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
		{
			original -= center;
			float C = cos( angle );
			float S = sin( angle );
			float t = 1 - C;
			float m00 = t * u.x * u.x + C;
			float m01 = t * u.x * u.y - S * u.z;
			float m02 = t * u.x * u.z + S * u.y;
			float m10 = t * u.x * u.y + S * u.z;
			float m11 = t * u.y * u.y + C;
			float m12 = t * u.y * u.z - S * u.x;
			float m20 = t * u.x * u.z - S * u.y;
			float m21 = t * u.y * u.z + S * u.x;
			float m22 = t * u.z * u.z + C;
			float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
			return mul( finalMatrix, original ) + center;
		}


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_18_0 = ( ( ase_vertex3Pos.y * cos( ( ( ( ase_worldPos.x + ase_worldPos.z ) * _WorldFrequency ) + _Time.y ) ) ) * _Blendamount );
			float4 appendResult19 = (float4(temp_output_18_0 , 0.0 , temp_output_18_0 , 0.0));
			float4 break23 = mul( appendResult19, unity_ObjectToWorld );
			float4 appendResult26 = (float4(break23.x , _Vector0.y , break23.z , 0.0));
			float3 rotatedValue27 = RotateAroundAxis( float3( 0,0,0 ), appendResult26.xyz, float3( 0,0,0 ), _winddirection );
			v.vertex.xyz += rotatedValue27;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 ase_worldPos = i.worldPos;
			float eyeDepth29 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, float4( ase_worldPos , 0.0 ).xy ));
			float3 temp_cast_1 = (( ase_vertex4Pos.y * abs( ( eyeDepth29 - ase_worldPos.z ) ) )).xxx;
			float3 temp_cast_2 = ((( _MovingGRadient )?( cos( ( 0.0 + _Time.y ) ) ):( _Gradientposition ))).xxx;
			float3 temp_cast_3 = (_Gradientsize).xxx;
			float4 lerpResult43 = lerp( _TopColor , _BottomColor , pow( ( distance( max( ( abs( ( temp_cast_1 - temp_cast_2 ) ) - ( temp_cast_3 * float3( 0.5,0.5,0.5 ) ) ) , float3( 0,0,0 ) ) , float3( 0,0,0 ) ) / _Gradientintensity ) , 0.5 ));
			o.Albedo = CalculateContrast(_Contrast,lerpResult43).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17700
0;40;2560;1337;2424.021;1698.174;1.3;True;True
Node;AmplifyShaderEditor.WorldPosInputsNode;1;-1005.736,1408.431;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;11;-1038.736,1741.431;Inherit;False;Property;_WorldFrequency;WorldFrequency;1;0;Create;True;0;0;False;0;0.07497557;0.07497557;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;2;-587.736,1440.431;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-400.7359,1468.431;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;12;-731.736,1892.431;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-200.7359,1710.431;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;28;-1429.54,-961.3254;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CosOpNode;14;18.2474,1796.103;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;48;-1918.955,-313.2954;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenDepthNode;29;-1179.139,-1245.502;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;15;-26.73587,1433.431;Inherit;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;235.2641,1655.431;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-91.7677,2099.729;Inherit;True;Property;_Blendamount;Blendamount;3;0;Create;True;0;0;False;0;0.001;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;30;-931.4693,-1208.351;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;-1381.709,-419.4594;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-682.3979,-989.829;Float;False;Property;_Gradientposition;Gradient position;7;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;32;-746.6416,-1137.348;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;547.05,1884.449;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;31;-1240.433,-1512.016;Inherit;True;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CosOpNode;46;-1163.889,-410.6234;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-710.5493,-764.77;Float;False;Property;_Gradientintensity;Gradient intensity;9;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;19;878.05,1825.449;Inherit;True;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ObjectToWorldMatrixNode;21;928.0507,2130.049;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-705.554,-855.7173;Float;False;Property;_Gradientsize;Gradient size;6;0;Create;True;0;0;False;0;0.82;0.82;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;45;-1347.131,-610.5204;Inherit;False;Property;_MovingGRadient;Moving GRadient;8;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-467.6107,-1346.627;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;1196.578,2013.682;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-322.4354,-538.1615;Float;False;Constant;_devider;devider;0;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;38;-282.7571,-1008.772;Inherit;True;BoxMask;-1;;3;9dce4093ad5a42b4aa255f0153c4f209;0;4;1;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;10;FLOAT3;0,0,0;False;17;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;24;1546.922,1508.536;Inherit;False;Property;_Vector0;Vector 0;4;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.BreakToComponentsNode;23;1494.578,1880.683;Inherit;True;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ColorNode;41;-397.7979,-1805.943;Float;False;Property;_TopColor;Top Color;0;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;40;-403.7979,-1608.943;Float;False;Property;_BottomColor;Bottom Color;5;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;39;204.4727,-734.3116;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;43;514.2631,-1439.418;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;26;2177.922,1698.537;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;42;1114.727,-649.0155;Float;False;Property;_Contrast;Contrast;10;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;1056.922,2318.537;Inherit;True;Property;_winddirection;wind direction;2;0;Create;True;0;0;False;0;0.2205882;0.2205882;0;6.25;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;44;1576.6,-786.4534;Inherit;True;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;27;2374.922,2130.537;Inherit;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2940.399,218.1376;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;TreeShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;1
WireConnection;2;1;1;3
WireConnection;3;0;2;0
WireConnection;3;1;11;0
WireConnection;13;0;3;0
WireConnection;13;1;12;2
WireConnection;14;0;13;0
WireConnection;29;0;28;0
WireConnection;16;0;15;2
WireConnection;16;1;14;0
WireConnection;30;0;29;0
WireConnection;30;1;28;3
WireConnection;47;1;48;2
WireConnection;32;0;30;0
WireConnection;18;0;16;0
WireConnection;18;1;17;0
WireConnection;46;0;47;0
WireConnection;19;0;18;0
WireConnection;19;2;18;0
WireConnection;45;0;33;0
WireConnection;45;1;46;0
WireConnection;35;0;31;2
WireConnection;35;1;32;0
WireConnection;22;0;19;0
WireConnection;22;1;21;0
WireConnection;38;1;35;0
WireConnection;38;4;45;0
WireConnection;38;10;36;0
WireConnection;38;17;34;0
WireConnection;23;0;22;0
WireConnection;39;0;38;0
WireConnection;39;1;37;0
WireConnection;43;0;41;0
WireConnection;43;1;40;0
WireConnection;43;2;39;0
WireConnection;26;0;23;0
WireConnection;26;1;24;2
WireConnection;26;2;23;2
WireConnection;44;1;43;0
WireConnection;44;0;42;0
WireConnection;27;1;25;0
WireConnection;27;3;26;0
WireConnection;0;0;44;0
WireConnection;0;11;27;0
ASEEND*/
//CHKSM=94C6E92E772144D197AEFA0807746585890B4E28