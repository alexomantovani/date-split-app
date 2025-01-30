import 'package:date_split_app/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

import 'package:date_split_app/core/common/widgets/custom_field.dart';
import 'package:date_split_app/core/utils/assets.dart';
import 'package:date_split_app/core/utils/styles.dart';

class PartyTabView extends StatefulWidget {
  const PartyTabView({super.key});

  @override
  State<PartyTabView> createState() => _PartyTabViewState();
}

class _PartyTabViewState extends State<PartyTabView> {
  final GlobalKey<FormState> _formKeyParties = GlobalKey<FormState>();
  final TextEditingController partyContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Form(
            key: _formKeyParties,
            child: CustomField(
              controller: partyContoller,
              filled: true,
              fillColour: Styles.kBgField,
              enabledBorderColor: Styles.kDescriptionText,
              prefixIcon: const Icon(Icons.search),
              hintText: 'Precure Rolês',
              onChanged: (value) {},
            ),
          ),
          const SizedBox(height: 20.0),
          Image.asset(Assets.kPlant),
          Text(
            'Sem rolês por aqui',
            style: context.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          Text(
            'Convide rolês para desbloquear funcionalidades',
            style: context.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
