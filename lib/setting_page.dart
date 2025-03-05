import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Plant Care Settings")),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
            subtitle: Text("Manage watering reminders"),
            trailing: Switch(
              value: notificationsEnabled,
              onChanged: (val) {
                setState(() {
                  notificationsEnabled = val;
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationSettings()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.water_drop),
            title: Text("Watering Schedule"),
            subtitle: Text("Customize plant watering times"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WateringSchedule()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.cloud_sync),
            title: Text("Plant Database Sync"),
            subtitle: Text("Sync data with cloud"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.palette),
            title: Text("Theme Mode"),
            subtitle: Text("Dark/Light mode"),
            trailing: Switch(
              value: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark,
              onChanged: (val) {
                Provider.of<ThemeProvider>(context, listen: false).setTheme(
                  val ? ThemeMode.dark : ThemeMode.light,
                );
              },
            ),
          ),

          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            subtitle: Text("Select app language"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.restore),
            title: Text("Reset Data"),
            subtitle: Text("Clear all app data"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
            subtitle: Text("Learn more about the app"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// ✅ Notification Settings Page
class NotificationSettings extends StatefulWidget {
  @override
  _NotificationSettingsState createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool notificationsEnabled = true;
  TimeOfDay selectedTime = TimeOfDay(hour: 8, minute: 0);
  bool wateringReminder = true;
  bool fertilizingReminder = false;

  void _pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notification Settings")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text("Enable Notifications"),
              subtitle: Text("Turn notifications on or off"),
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ),
            ListTile(
              title: Text("Set Reminder Time"),
              subtitle: Text("Selected Time: ${selectedTime.format(context)}"),
              trailing: Icon(Icons.timer),
              onTap: _pickTime,
            ),
            SwitchListTile(
              title: Text("Watering Reminders"),
              subtitle: Text("Get reminders to water your plants"),
              value: wateringReminder,
              onChanged: (value) {
                setState(() {
                  wateringReminder = value;
                });
              },
            ),
            SwitchListTile(
              title: Text("Fertilizing Reminders"),
              subtitle: Text("Get reminders to fertilize your plants"),
              value: fertilizingReminder,
              onChanged: (value) {
                setState(() {
                  fertilizingReminder = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Watering Schedule Page
class WateringSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Watering Schedule")),
      body: Center(child: Text("Customize your watering schedule here.")),
    );
  }
}
