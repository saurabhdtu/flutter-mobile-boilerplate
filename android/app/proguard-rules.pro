-keep class com.zinc.money.tools.SmsBroadcastReceiver { *; }
-keep class com.google.android.gms.** { *; }
-keep class com.google.api.** { *; }
-keep class com.google.android.gms.auth.api.phone.** { *; }
-keepclassmembers class * {
    @com.google.android.gms.auth.api.phone.SmsRetrieverApi <methods>;
}