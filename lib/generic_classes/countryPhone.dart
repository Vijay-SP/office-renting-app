import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountryPhone extends StatelessWidget {
  final void Function(String, String) onIsoChange;
  final TextEditingController phoneController;
  final String? initialIsoCode;
  const CountryPhone(
      {Key? key,
      this.initialIsoCode,
      required this.onIsoChange,
      required this.phoneController})
      : super(key: key);

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}"),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: CountryPickerDropdown(
              initialValue: initialIsoCode ?? 'GB',
              itemBuilder: _buildDropdownItem,
              priorityList: [
                CountryPickerUtils.getCountryByIsoCode('GB'),
                CountryPickerUtils.getCountryByIsoCode('CN'),
              ],
              sortComparator: (Country a, Country b) =>
                  a.isoCode.compareTo(b.isoCode),
              onValuePicked: (Country country) {
                onIsoChange(country.phoneCode, country.isoCode);
              },
            ),
          ),
          Flexible(
            child: TextFormField(
              controller: phoneController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter phone no.";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Phone",
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none
              ),
              keyboardType: TextInputType.number,
            ),
          )
        ],
      ),
    );
  }
}

// child: InternationalPhoneNumberInput(
//   // initialValue: ,
//   selectorButtonOnErrorPadding: 10,
//   onInputChanged: onChange,
//   inputBorder: InputBorder.none,
//   selectorConfig: SelectorConfig(showFlags: true, useEmoji: true),
// ),
