#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

go_version="1.23.3"


#=================================================
# PERSONAL HELPERS
#=================================================

_set_frequencies() {

    case $frequency_hour in
      "Midnight")          frequency_time="0" ; ynh_app_setting_set --app="$app" --key="frequency_time" --value="$frequency_time" ;;
      "2am")               frequency_time="2" ; ynh_app_setting_set --app="$app" --key="frequency_time" --value="$frequency_time" ;;
      "3am")               frequency_time="3" ; ynh_app_setting_set --app="$app" --key="frequency_time" --value="$frequency_time" ;;
      "4am")               frequency_time="4" ; ynh_app_setting_set --app="$app" --key="frequency_time" --value="$frequency_time" ;;
      "6am")               frequency_time="6" ; ynh_app_setting_set --app="$app" --key="frequency_time" --value="$frequency_time" ;;
    esac
    
    esac 
    case "$frequency" in
        daily)
            frequency_cron="0 $frequency_time * * *"
            frequency_human="every day at $frequency_time am"
            ;;
        days_3)
            frequency_cron="0 $frequency_time */3 * *"
            frequency_human="each 3 days at $frequency_time am"
            ;;
        weekly)
            frequency_cron="0 $frequency_time * * 0"
            frequency_human="once a week on sunday at $frequency_time am"
            ;;
        weeks_2)
            frequency_cron="0 $frequency_time * * 0/2"
            frequency_human="one sunday out of two at $frequency_time am"
            ;;
        monthly)
            frequency_cron="0 $frequency_time 1 * *"
            frequency_human="once a month on the first sunday at $frequency_time am"
            ;;
        *)
            ynh_die --message="Unsupported frequency $frequency" ;;
    esac

    # For POST_INSTALL.md
    ynh_app_setting_set --app="$app" --key=frequency_human --value="$frequency_human"
}

_fix_frequencies() {
    case "$frequency" in
        Daily)          frequency="daily" ; ynh_app_setting_set --app="$app" --key="frequency" --value="$frequency" ;;
        "Each 3 days")  frequency="days_3" ; ynh_app_setting_set --app="$app" --key="frequency" --value="$frequency" ;;
        "Weekly")       frequency="weekly" ; ynh_app_setting_set --app="$app" --key="frequency" --value="$frequency" ;;
        "Biweekly")     frequency="weeks_2" ; ynh_app_setting_set --app="$app" --key="frequency" --value="$frequency" ;;
        "Monthly")      frequency="monthly" ; ynh_app_setting_set --app="$app" --key="frequency" --value="$frequency" ;;
    esac
}
