package com.example.tv_randshow;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.os.Build;
import android.view.ViewTreeObserver;
import android.view.WindowManager;
public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    boolean flutter_native_splash = true;
    int originalStatusBarColor = 0;
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
        originalStatusBarColor = getWindow().getStatusBarColor();
        getWindow().setStatusBarColor(0xffe40505);
    }
    int originalStatusBarColorFinal = originalStatusBarColor;

    GeneratedPluginRegistrant.registerWith(this);
    ViewTreeObserver vto = getFlutterView().getViewTreeObserver();
    vto.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
      @Override
      public void onGlobalLayout() {
        getFlutterView().getViewTreeObserver().removeOnGlobalLayoutListener(this);
        getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
          getWindow().setStatusBarColor(originalStatusBarColorFinal);
        }
      }
    });

  }
}