package com.gostcorp.driver_clone;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceBundle){
        super.onCreate(savedInstanceBundle);
    }

    @NonNull
    @Override
    public String getInitialRoute() {
        String route = getIntent().getStringExtra("route");
        if (route != null) {
            return route;
        } else {
            return "welcome_page";
        }
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine){
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(),"myPluginsChannel")
                .setMethodCallHandler((call,result)->{
                    try{
                        if(call.method.equals("launchMap")){
                            double latitude = call.argument("latitude");
                            double longitude= call.argument("longitude");
                            String uri = "google.navigation:q="+latitude+","+longitude;
                            Uri gmmIntentUri = Uri.parse(uri);
                            Intent mapIntent = new Intent(Intent.ACTION_VIEW, gmmIntentUri);
                            mapIntent.setPackage("com.google.android.apps.maps");
                            if (mapIntent.resolveActivity(getPackageManager()) != null) {
                                startActivity(mapIntent);
                                result.success(true);
                            }
                        }
                    }catch(Exception e){
                        result.error("error","error",false);
                    }
                });
    }
}
