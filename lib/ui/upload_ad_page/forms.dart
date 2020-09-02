import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jumpets_app/app_localizations.dart';
import 'package:jumpets_app/blocs/upload_ad_bloc/upload_ad_bloc.dart';
import 'package:jumpets_app/ui/components/buttons/category_button.dart';
import 'package:jumpets_app/ui/components/buttons/flat_button.dart';
import 'package:jumpets_app/ui/components/buttons/raised_button.dart';
import 'package:formz/formz.dart';
import 'package:jumpets_app/models/models.dart';
import 'package:jumpets_app/ui/components/buttons/sex_radio_button.dart';
import 'package:jumpets_app/ui/components/buttons/text_radio_button.dart';
import 'package:jumpets_app/ui/components/jumpets_icons_icons.dart';
import 'package:jumpets_app/ui/components/tags.dart';

class AdNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAdBloc, UploadAdState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('ad_nameinput_textfield'),
          onChanged: (name) =>
              context.bloc<UploadAdBloc>().add(AdNameChanged(name)),
          decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400)),
              errorStyle: TextStyle(color: Colors.red.shade400),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black54),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54)),
              labelText: AppLocalizations.of(context).translate('name'),
              labelStyle: TextStyle(color: Colors.black54)),
        );
      },
    );
  }
}

class AdDescriptionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAdBloc, UploadAdState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        return TextField(
          key: const Key('ad_descriptioninput_textfield'),
          onChanged: (description) => context
              .bloc<UploadAdBloc>()
              .add(AdDescriptionChanged(description)),
          decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400)),
              errorStyle: TextStyle(color: Colors.red.shade400),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black54),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54)),
              labelText: AppLocalizations.of(context).translate('description'),
              labelStyle: TextStyle(color: Colors.black54)),
        );
      },
    );
  }
}

class AdMustKnowInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAdBloc, UploadAdState>(
      buildWhen: (previous, current) => previous.mustKnow != current.mustKnow,
      builder: (context, state) {
        return TextField(
          key: const Key('ad_mustKnowinput_textfield'),
          onChanged: (mustKnow) =>
              context.bloc<UploadAdBloc>().add(AdMustKnowChanged(mustKnow)),
          decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400)),
              errorStyle: TextStyle(color: Colors.red.shade400),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black54),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54)),
              labelText: AppLocalizations.of(context).translate('must_know'),
              labelStyle: TextStyle(color: Colors.black54)),
        );
      },
    );
  }
}

class AdBreedInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAdBloc, UploadAdState>(
      buildWhen: (previous, current) => previous.breed != current.breed,
      builder: (context, state) {
        return TextField(
          key: const Key('ad_breedinput_textfield'),
          onChanged: (breed) =>
              context.bloc<UploadAdBloc>().add(AdBreedChanged(breed)),
          decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400)),
              errorStyle: TextStyle(color: Colors.red.shade400),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black54),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54)),
              labelText: AppLocalizations.of(context).translate('breed'),
              labelStyle: TextStyle(color: Colors.black54)),
        );
      },
    );
  }
}

class AdAdoptionTaxInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAdBloc, UploadAdState>(
      buildWhen: (previous, current) =>
          previous.adoptionTax != current.adoptionTax,
      builder: (context, state) {
        return TextField(
          key: const Key('ad_adoptionTaxinput_textfield'),
          onChanged: (adoptionTax) => context
              .bloc<UploadAdBloc>()
              .add(AdAdoptionTaxChanged(double.parse(adoptionTax))),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
          decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400)),
              errorStyle: TextStyle(color: Colors.red.shade400),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black54),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54)),
              labelText: AppLocalizations.of(context).translate('adoption_tax'),
              labelStyle: TextStyle(color: Colors.black54)),
        );
      },
    );
  }
}

class AdWeightInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAdBloc, UploadAdState>(
      buildWhen: (previous, current) => previous.weight != current.weight,
      builder: (context, state) {
        return TextField(
          key: const Key('ad_weightinput_textfield'),
          onChanged: (weight) => context
              .bloc<UploadAdBloc>()
              .add(AdWeightChanged(double.parse(weight))),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
          decoration: InputDecoration(
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400)),
              errorStyle: TextStyle(color: Colors.red.shade400),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red.shade400)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black54),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black54)),
              labelText: AppLocalizations.of(context).translate('weight'),
              labelStyle: TextStyle(color: Colors.black54)),
        );
      },
    );
  }
}

class AdBirthDate extends StatelessWidget {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      locale: AppLocalizations.of(context).locale,
      context: context,
      initialDate:
          context.bloc<UploadAdBloc>().state.birthDate ?? DateTime.now(),
      firstDate: DateTime(2000, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null &&
        picked != context.bloc<UploadAdBloc>().state.birthDate) {
      context.bloc<UploadAdBloc>().add(AdBirthDateChanged(picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAdBloc, UploadAdState>(
      buildWhen: (previous, current) => previous.birthDate != current.birthDate,
      builder: (context, state) {
        return Row(children: [
          Text('${state.birthDate?.toLocal() ?? DateTime.now().toLocal()}'
              .split(' ')
              .first),
          Spacer(),
          MyFlatButton(
            onTap: () => _selectDate(context),
            child: Text(
                AppLocalizations.of(context).translate('select_birthdate')),
          )
        ]);
      },
    );
  }
}

class AdSexInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAdBloc, UploadAdState>(
      buildWhen: (previous, current) => previous.male != current.male,
      builder: (context, state) {
        return Row(children: [
          Text(AppLocalizations.of(context)
                  .translate(state.male?.toStringFromSex()?.toLowerCase()) ??
              AppLocalizations.of(context).translate('sex')),
          Spacer(),
          SexRadioButton(
              male: true,
              isSelected: state.male ?? false,
              onTap: () =>
                  context.bloc<UploadAdBloc>().add(AdSexChanged(true))),
          SexRadioButton(
              male: false,
              isSelected: !(state.male ?? true),
              onTap: () =>
                  context.bloc<UploadAdBloc>().add(AdSexChanged(false))),
        ]);
      },
    );
  }
}

class AdDogSizeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAdBloc, UploadAdState>(
      buildWhen: (previous, current) => previous.dogSize != current.dogSize,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(AppLocalizations.of(context).translate('size')),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: DogSize.values
                    .map((dogSize) => TextRadioButton(
                        text: AppLocalizations.of(context).translate(
                            'dog_size_${dogSize.name.toLowerCase()}'),
                        isSelected: state.dogSize == dogSize,
                        onTap: () => context
                            .bloc<UploadAdBloc>()
                            .add(AdDogSizeChanged(dogSize))))
                    .toList()),
          ]),
        );
      },
    );
  }
}

class AdActivityLevelInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAdBloc, UploadAdState>(
      buildWhen: (previous, current) =>
          previous.activityLevel != current.activityLevel,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(AppLocalizations.of(context).translate('activity_level')),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ActivityLevel.values
                    .map((activityLevel) => TextRadioButton(
                        text: AppLocalizations.of(context).translate(
                            'activity_level_${activityLevel.name.toLowerCase()}'),
                        isSelected: state.activityLevel == activityLevel,
                        onTap: () => context
                            .bloc<UploadAdBloc>()
                            .add(AdActivityLevelChanged(activityLevel))))
                    .toList()),
          ]),
        );
      },
    );
  }
}

class AdDeliveryInfoInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAdBloc, UploadAdState>(
      buildWhen: (previous, current) =>
          previous.deliveryInfo != current.deliveryInfo,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppLocalizations.of(context).translate('delivery_info')} (${state.deliveryInfo?.length ?? 0})',
                ),
                MyFlatButton(
                  onTap: () {
                    if ((state.deliveryInfo?.length ?? 0) !=
                        DeliveryStatus.values.toList().length) {
                      context.bloc<UploadAdBloc>().add(AdDeliveryInfoChanged(
                          DeliveryStatus.values.toList()));
                    } else {
                      context
                          .bloc<UploadAdBloc>()
                          .add(AdDeliveryInfoChanged([]));
                    }
                  },
                  child: Text(
                      (state.deliveryInfo?.length ?? 0) ==
                              DeliveryStatus.values.toList().length
                          ? AppLocalizations.of(context)
                              .translate('clear')
                              .toLowerCase()
                          : AppLocalizations.of(context)
                              .translate('all')
                              .toLowerCase(),
                      style: Theme.of(context).textTheme.button),
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: DeliveryStatus.values
                      .map((deliveryStatus) => TextRadioButton(
                          text: AppLocalizations.of(context)
                              .translate(deliveryStatus.name.toLowerCase()),
                          isSelected:
                              state.deliveryInfo.contains(deliveryStatus),
                          onTap: () {
                            List<DeliveryStatus> list = state.deliveryInfo;

                            if (list.contains(deliveryStatus)) {
                              list.remove(deliveryStatus);
                            } else {
                              list.add(deliveryStatus);
                            }

                            context
                                .bloc<UploadAdBloc>()
                                .add(AdDeliveryInfoChanged(list));
                          }))
                      .toList()),
            ),
          ]),
        );
      },
    );
  }
}

class AdPersonalityInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAdBloc, UploadAdState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
              AppLocalizations.of(context).translate('personality'),
            ),
            Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                children: <Widget>[]
                  ..addAll(
                      state.personality.map((tag) => Tag(tag: tag)).toList())
                  ..add(InputTag(
                    onTap: (value) {
                      if (!state.personality.contains(value)) {
                        context.bloc<UploadAdBloc>().add(AdPersonalityChanged(
                            state.personality..add(value)));
                      }
                    },
                  ))),
          ]),
        );
      },
    );
  }
}

class AdTagsInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAdBloc, UploadAdState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
              AppLocalizations.of(context).translate('tags'),
            ),
            Wrap(
                alignment: WrapAlignment.start,
                direction: Axis.horizontal,
                children: <Widget>[]
                  ..addAll(state.tags.map((tag) => Tag(tag: tag)).toList())
                  ..add(InputTag(
                    onTap: (value) {
                      if (!state.tags.contains(value)) {
                        context
                            .bloc<UploadAdBloc>()
                            .add(AdTagsChanged(state.tags..add(value)));
                      }
                    },
                  ))),
          ]),
        );
      },
    );
  }
}

class AdPhotosInput extends StatelessWidget {
  final picker = ImagePicker();

  Future getImage(BuildContext context, int index) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      context.bloc<UploadAdBloc>().add(AdImgChanged(
          context.bloc<UploadAdBloc>().state.photos
            ..add(File(pickedFile.path))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAdBloc, UploadAdState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    3,
                    (index) =>
                        _getWidgetImageFromIndex(context, index, state))),
            SizedBox(
              height: 10,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    3,
                    (index) =>
                        _getWidgetImageFromIndex(context, index + 3, state))),
          ]),
        );
      },
    );
  }

  Widget _getWidgetImageFromIndex(context, int index, UploadAdState state) {
    Widget child = Icon(JumpetsIcons.camara,
        color: Theme.of(context).accentColor, size: 30);

    if (state.photos.length > index) {
      child = ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.file(
          state.photos[index],
          fit: BoxFit.cover,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RoundedSquareButton(
          borderRadius: 15,
          size: 70,
          child: child,
          onTap: () => getImage(context, index),
          isSelected: false),
    );
  }
}

class UploadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadAdBloc, UploadAdState>(
      builder: (context, state) {
        return MyRaisedButton(
          onPressed: () => context.bloc<UploadAdBloc>().add(AdSubmitted()),
          text: AppLocalizations.of(context).translate('upload'),
          blocked: !context.bloc<UploadAdBloc>().isValid,
          child: state.status.isSubmissionInProgress
              ? CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                )
              : null,
        );
      },
    );
  }
}
