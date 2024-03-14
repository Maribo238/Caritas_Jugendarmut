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
                                        RemoteViews(context.packageName, R.layout.home_widget)
                                                        .apply {
                                                                val count =
                                                                                widgetData.getLong(
                                                                                                "amount",
                                                                                                0
                                                                                )
                                                                setTextViewText(
                                                                                R.id.amount,
                                                                                count.toString()
                                                                )

                                                                val incrementIntent =
                                                                                HomeWidgetBackgroundIntent
                                                                                                .getBroadcast(
                                                                                                                context,
                                                                                                                Uri.parse(
                                                                                                                                "homeWidgetCounter://increment"
                                                                                                                )
                                                                                                )

                                                                val clearIntent =
                                                                                HomeWidgetBackgroundIntent
                                                                                                .getBroadcast(
                                                                                                                context,
                                                                                                                Uri.parse(
                                                                                                                                "homeWidgetCounter://clear"
                                                                                                                )
                                                                                                )

                                                                val intent =
                                                                                Intent(
                                                                                                context,
                                                                                                MainActivity::class
                                                                                                                .java
                                                                                )
                                                                intent.action =
                                                                                "com.example.home_widget.PEN_CLICKED"
                                                                val pendingIntent =
                                                                                PendingIntent.getBroadcast(
                                                                                                context,
                                                                                                0,
                                                                                                intent,
                                                                                                PendingIntent.FLAG_UPDATE_CURRENT
                                                                                )

                                                                setOnClickPendingIntent(
                                                                                R.id.button_2,
                                                                                pendingIntent
                                                                )
                                                                setOnClickPendingIntent(
                                                                                R.id.button_1,
                                                                                incrementIntent
                                                                )
                                                                setOnClickPendingIntent(
                                                                                R.id.button_5,
                                                                                clearIntent
                                                                )
                                                        }
                        appWidgetManager.updateAppWidget(widgetId, views)
                }
        }
}
