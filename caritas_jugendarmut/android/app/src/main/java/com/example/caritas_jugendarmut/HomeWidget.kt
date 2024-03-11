package com.example.caritas_jugendarmut

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
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
            val views = RemoteViews(context.packageName, R.layout.home_widget).apply {
                val count = widgetData.getLong(
                    "amount", 0L
                )

                setTextViewText(
                    R.id.titleText, count.toString()
                )

                val incrementIntent1 = HomeWidgetBackgroundIntent.getBroadcast(
                    context,
                    Uri.parse(
                        "homeWidgetCounter://1"
                    )
                )

                val incrementIntet2 = HomeWidgetBackgroundIntent.getBroadcast(
                    context,
                    Uri.parse(
                        "homeWidgetCounter://2"
                    )
                )

                val incrementIntent5 = HomeWidgetBackgroundIntent.getBroadcast(
                    context,
                    Uri.parse(
                        "homeWidgetCounter://5"
                    )
                )

                val intent = Intent(
                    context,
                    MainActivity::class.java
                )

                setOnClickPendingIntent(
                    R.id.button_2, incrementIntet2
                )
                setOnClickPendingIntent(
                    R.id.button_1, incrementIntent1
                )
                setOnClickPendingIntent(
                    R.id.button_5, incrementIntent5
                )
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }

}
