package com.example.caritas_jugendarmut

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.graphics.Color
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetProvider
import io.flutter.Log

/** Implementation of App Widget functionality. */
class HomeWidget : HomeWidgetProvider() {

    override fun onUpdate(
            context: Context,
            appWidgetManager: AppWidgetManager,
            appWidgetIds: IntArray,
            widgetData: SharedPreferences
    ) {
        // There may be multiple widgets active, so update all of them
        appWidgetIds.forEach { widgetId ->

            // Add the click listener to the button
            val views =
                    RemoteViews(context.packageName, R.layout.home_widget).apply {
                        val count = widgetData.getInt("counter", 0)
                        setTextViewText(R.id.text_counter, count.toString())

                        val incrementIntent =
                                HomeWidgetBackgroundIntent.getBroadcast(
                                        context,
                                        Uri.parse("homeWidgetCounter://increment")
                                )

                        val clearIntent =
                                HomeWidgetBackgroundIntent.getBroadcast(
                                        context,
                                        Uri.parse("homeWidgetCounter://clear")
                                )

                        val intent = Intent(context, MainActivity::class.java)
                        intent.action = "com.example.home_widget.PEN_CLICKED"
                        val pendingIntent =
                                PendingIntent.getBroadcast(
                                        context,
                                        0,
                                        intent,
                                        PendingIntent.FLAG_UPDATE_CURRENT
                                )

                        setOnClickPendingIntent(R.id.button_clear, pendingIntent)
                        setInt(R.id.button_increment, "setBackgroundColor", Color.BLUE)
                        setOnClickPendingIntent(R.id.button_increment, incrementIntent)
                        // setOnClickPendingIntent(R.id.button_clear, clearIntent)
                    }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)

        if (intent.action == "com.example.mywidget.PEN_CLICKED") {
            // Stiftsymbol wurde geklickt
            Log.d("MyWidgetProvider", "Stiftsymbol wurde geklickt!")
        }
    }
}
