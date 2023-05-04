import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../helpers/consts.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingState();
}

class _SettingState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: darkBackroundScreenColor,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          child: ListView(
            children: [
               Text(
                AppLocalizations.of(context)!.settings,
                style:const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: mainColor),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    color: mainColor.withOpacity(.5),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(AppLocalizations.of(context)!.account,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500])),
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
                color: greyColor,
              ),
              const SizedBox(
                height: 10,
              ),
              PopupMenuButton(
                constraints: const BoxConstraints(
                  minWidth: 2.0 * 56.0,
                  maxWidth: 5.0 * 56.0,
                ),
                child: SettingsRowButton(
                  title: AppLocalizations.of(context)!.resttitl1,
                ),
                itemBuilder: (_) => [
                  const PopupMenuItem(
                    value: 'item1',
                    child: Text('Item1'),
                  ),
                  const PopupMenuItem(value: 'item2', child: Text('Item2')),
                ],
                onSelected: (value) => Navigator.of(context).pushNamed(value),
              ),
              SettingsRowButton(
                title:AppLocalizations.of(context)!.edityc,
              ),
              SettingsRowButton(
                title: AppLocalizations.of(context)!.lag,
              ),
              SettingsRowButton(
                title:AppLocalizations.of(context)!.dakmo,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Icon(Icons.volume_up_outlined,
                      color: mainColor.withOpacity(.5)),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(AppLocalizations.of(context)!.notification,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500])),
                ],
              ),
              const Divider(
                height: 15,
                thickness: 2,
                color: greyColor,
              ),
              const SizedBox(
                height: 10,
              ),
              // buildNotificationsOptionRow("New For You", true),
              buildNotificationsOptionRow(AppLocalizations.of(context)!.activte, true),

              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ));
  }

  Padding buildAccountOptionRow(BuildContext context, String title) {
    bool isChecked = false;
    List<String> item = ["Male ", "Female "];
    String currentitem =
        " ${AppLocalizations.of(context)!.lag}   (${AppLocalizations.of(context)!.localeName == 'en' ? (AppLocalizations.of(context)!.lanen) : (AppLocalizations.of(context)!.lanar)})";

    void handleChange(String? value) {
      setState(() {
        currentitem = value!;
      });
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          PopupMenuButton(
            child: const Text('Some Button'),
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'item1',
                child: Text('Item1'),
              ),
              const PopupMenuItem(value: 'item2', child: Text('Item2')),
            ],
            onSelected: (value) => Navigator.of(context).pushNamed(value),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400]),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: mainColor,
            )
          ],
        ),
      ),
    );
  }

  Row buildNotificationsOptionRow(String title, bool isActive) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400]),
        ),
        Switch(
            value: isActive, onChanged: (bool val) {}, activeColor: mainColor)
      ],
    );
  }
}

class SettingsRowButton extends StatelessWidget {
  const SettingsRowButton({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[400]),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: mainColor,
          )
        ],
      ),
    );
  }
}
