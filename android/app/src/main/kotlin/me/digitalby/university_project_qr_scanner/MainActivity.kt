package me.digitalby.university_project_qr_scanner

import android.content.pm.ActivityInfo
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun getRequestedOrientation(): Int {
        return ActivityInfo.SCREEN_ORIENTATION_PORTRAIT
    }
}
