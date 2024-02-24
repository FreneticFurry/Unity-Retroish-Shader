
    Shader "Frenetic/Pixel" {
        Properties {
            _MainTex ("Texture", 2D) = "white" {}
            _PixelSize ("Pixel Size", Range(0.001, 0.025)) = 0.0075
            [HideInInspector]_Intensity ("Intensity", Range(0.0, 1.0)) = 0.00001
            _TintColor ("Tint Color", Color) = (1, 1, 1, 1)
        }
    
        SubShader {
            Tags { "RenderType"="Opaque" }
    
            CGPROGRAM
            #pragma surface surf Standard fullforwardshadows vertex:vert
    
            #include "UnityCG.cginc"
    
            struct Input {
                float2 uv_MainTex;
            };
    
            sampler2D _MainTex;
            float _PixelSize;
            float _Intensity;
            fixed4 _TintColor;
    
            void vert(inout appdata_full v, out Input o) {
                float timeFactor = _Time.y * 1.0;
                float factum = _PixelSize - _PixelSize - _PixelSize;
                float sineWave = sin(timeFactor + factum) * _Intensity;
                float pixelSize = _PixelSize + sineWave;
    
                v.vertex.xyz = floor(v.vertex.xyz / pixelSize) * pixelSize;
                o.uv_MainTex = v.texcoord;
            }
    
            void surf(Input IN, inout SurfaceOutputStandard o) {
                fixed4 texColor = tex2D(_MainTex, IN.uv_MainTex);
                fixed4 tintedColor = texColor * _TintColor;
                o.Albedo = tintedColor.rgb;
                o.Alpha = texColor.a;
            }
            ENDCG
        }
    
        FallBack "Standard"
    }
    
