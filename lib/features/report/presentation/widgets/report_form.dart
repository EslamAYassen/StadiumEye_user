import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_event.dart';

import 'package:stadium_eye/features/report/presentation/widgets/custom_submit_button.dart';
import 'package:stadium_eye/features/report/presentation/widgets/media_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_theme_consts.dart';
import '../../domain/entities/city_entity.dart';
import '../../domain/entities/country_entity.dart';
import '../../domain/entities/stadium_list_entity.dart';
import '../../domain/usecases/create_report_usecase.dart';
import '../bloc/report_bloc.dart';
import '../bloc/report_state.dart';
import 'custom_text_field.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({super.key});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  final _observationsCtrl = TextEditingController();
  // final _challengesCtrl = TextEditingController();
  // final _lessonsCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Selected values
  String? selectedCountryId;
  String? selectedCityId;
  String? selectedStadiumId;
  String? selectedArea;
  // String? selectedTicketType;
  String? selectedModelType;
  bool selectedMode = false; 

  // Stored data to prevent loss on state changes
  List<CountryEntity> _countries = [];
  List<CityEntity> _cities = [];
  List<CityEntity> _filteredCities = [];
  List<StadiumListEntity> _stadiums = [];
  List<StadiumListEntity> _filteredStadiums = [];

  // Loading states
  bool _isLoadingCountries = false;
  bool _isLoadingCities = false;
  bool _isLoadingStadiums = false;

  // Media files
  List<String> _imagePaths = [];
  List<String> _videoPaths = [];
  List<String> _voicePaths = [];

  // Form completion state
  bool _isFormComplete = false;

  @override
  void initState() {
    super.initState();
    if(selectedMode == true){
      selectedModelType = null;
    }

    context.read<ReportsBloc>().add(const LoadCountriesEvent());
    // Add listeners to text controllers
    _observationsCtrl.addListener(_checkFormCompletion);
    // _challengesCtrl.addListener(_checkFormCompletion);
    // _lessonsCtrl.addListener(_checkFormCompletion);
  }

  @override
  void dispose() {
    _observationsCtrl.removeListener(_checkFormCompletion);
    // _challengesCtrl.removeListener(_checkFormCompletion);
    // _lessonsCtrl.removeListener(_checkFormCompletion);

    _observationsCtrl.dispose();
    // _challengesCtrl.dispose();
    // _lessonsCtrl.dispose();
    super.dispose();
  }

  void _checkFormCompletion() {
    final isComplete =
        selectedCountryId != null &&
        selectedCityId != null &&
        selectedStadiumId != null &&
        selectedArea != null &&
        // selectedTicketType != null &&
        _observationsCtrl.text.trim().isNotEmpty; // &&
        // _challengesCtrl.text.trim().isNotEmpty &&
        // _lessonsCtrl.text.trim().isNotEmpty;

    if (_isFormComplete != isComplete) {
      setState(() {
        _isFormComplete = isComplete;
      });
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      if (selectedStadiumId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a stadium'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (selectedArea == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an area'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // if (selectedTicketType == null) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text('Please select a ticket type'),
      //       backgroundColor: Colors.red,
      //     ),
      //   );
      //   return;
      // }
      if (selectedModelType == null && selectedMode == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a model type'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      context.read<ReportsBloc>().add(
        CreateReportEvent(
          CreateReportParams(
            stadiumId: selectedStadiumId ?? '',
            area: selectedArea ?? '',
            // ticketType: selectedTicketType ,
            modelType: selectedModelType ,
            observations: _observationsCtrl.text.trim(),
            // challenges: _challengesCtrl.text.trim(),
            // lessonsLearned: _lessonsCtrl.text.trim(),
            ticketImagesPaths: _imagePaths.isNotEmpty ? _imagePaths : null,
            ticketVideosPaths: _videoPaths.isNotEmpty ? _videoPaths : null,
            ticketVoicesPaths: _voicePaths.isNotEmpty ? _voicePaths : null, mode: selectedMode,
          ),
        ),
      );
    }
  }

  void _onCountrySelected(String? countryId) {
    setState(() {
      selectedCountryId = countryId;
      selectedCityId = null; // Reset city
      selectedStadiumId = null; // Reset stadium

      // Filter cities by selected country
      if (countryId != null) {
        _filteredCities = _cities
            .where((city) => city.countryId == countryId)
            .toList();
        _filteredStadiums = []; // Clear stadiums
      } else {
        _filteredCities = [];
        _filteredStadiums = [];
      }
    });

    // Load cities if not loaded yet
    if (countryId != null && _cities.isEmpty) {
      context.read<ReportsBloc>().add(const LoadCitiesEvent());
    }
    _checkFormCompletion();
  }

  void _onCitySelected(String? cityId) {
    setState(() {
      selectedCityId = cityId;
      selectedStadiumId = null; // Reset stadium

      // Filter stadiums by selected city
      if (cityId != null) {
        _filteredStadiums = _stadiums
            .where((stadium) => stadium.cityId == cityId)
            .toList();
      } else {
        _filteredStadiums = [];
      }
    });

    // Load stadiums if not loaded yet
    if (cityId != null && _stadiums.isEmpty) {
      context.read<ReportsBloc>().add(const LoadStadiumsEvent());
    }
    _checkFormCompletion();
  }

  void _onStadiumSelected(String? stadiumId) {
    setState(() {
      selectedStadiumId = stadiumId;
    });
    _checkFormCompletion();
  }

  void _onAreaSelected(String? area) {
    setState(() {
      selectedArea = area;
    });
    _checkFormCompletion();
  }

  // void _onTicketTypeSelected(String? ticketType) {
  //   setState(() {
  //     selectedTicketType = ticketType;
  //   });
  //   _checkFormCompletion();
  // }

  void _onModelTypeSelected(String? modelType) {
    setState(() {
      selectedModelType = modelType;
    });
    _checkFormCompletion();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    return BlocConsumer<ReportsBloc, ReportsState>(
      listener: (context, state) {
        debugPrint('State: $state');
        if (state is CountriesLoaded) {
          setState(() {
            _countries = state.countries.countries;
            _isLoadingCountries = false;
          });
        } else if (state is CitiesLoaded) {
          setState(() {
            _cities = state.cities.cities;
            _isLoadingCities = false;

            // Filter by selected country
            if (selectedCountryId != null) {
              _filteredCities = _cities
                  .where((city) => city.countryId == selectedCountryId)
                  .toList();
            }
          });
        } else if (state is StadiumsLoaded) {
          setState(() {
            _stadiums = state.stadiums.stadiums;
            _isLoadingStadiums = false;

            // Filter by selected city
            if (selectedCityId != null) {
              _filteredStadiums = _stadiums
                  .where((stadium) => stadium.cityId == selectedCityId)
                  .toList();
            }
          });
        } else if (state is ReportsLoading) {
          // Determine what's loading
          if (_countries.isEmpty) {
            setState(() => _isLoadingCountries = true);
          } else if (_cities.isEmpty) {
            setState(() => _isLoadingCities = true);
          } else if (_stadiums.isEmpty) {
            setState(() => _isLoadingStadiums = true);
          }
        } else if (state is ReportsError) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.bottomSlide,
            title: locale.error,
            desc: state.message,
          ).show();

          setState(() {
            _isLoadingCountries = false;
            _isLoadingCities = false;
            _isLoadingStadiums = false;
          });
        } else if (state is ReportCreated) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.bottomSlide,
            title: locale.submitted,
            desc: state.message,
          ).show();
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! Country Dropdown
              _buildLabel(locale.country),
              const SizedBox(height: 8),
              _isLoadingCountries
                  ? const Center(
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: LottieLoader(),
                      ),
                    )
                  : _buildCountryDropdown(),
              const SizedBox(height: 26),

              //! City Dropdown
              _buildLabel(locale.city),
              const SizedBox(height: 8),
              _isLoadingCities
                  ? const Center(
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: LottieLoader(),
                      ),
                    )
                  : _buildCityDropdown(),
              const SizedBox(height: 26),

              //! Stadium Dropdown
              _buildLabel(locale.stadium),
              const SizedBox(height: 8),
              _isLoadingStadiums
                  ? const Center(
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: LottieLoader(),
                      ),
                    )
                  : _buildStadiumDropdown(),
              const SizedBox(height: 26),

              //! Area Dropdown
              _buildLabel(locale.area),
              const SizedBox(height: 8),
              _buildAreaDropdown(),
              const SizedBox(height: 26),

              // //! Ticket Type Dropdown
              // _buildLabel(locale.ticketType),
              // const SizedBox(height: 8),
              // _buildTicketTypeDropdown(),
              // const SizedBox(height: 26),

              //! Model Type Dropdown
              if(selectedMode == true)...[
                   _buildLabel(locale.modelType),
              const SizedBox(height: 8),
              _buildModelTypeDropdown(),
              const SizedBox(height: 26),
              ],
           

              //! Observations
              _buildLabel(locale.observations),
              const SizedBox(height: 8),
              CustomTextField(
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
                keyboardType: TextInputType.text,
                controller: _observationsCtrl,
                hint: locale.describeObservations,
                maxLines: 5,
              ),
              const SizedBox(height: 26),

              // //! Challenges
              // _buildLabel(locale.challenges),

              // const SizedBox(height: 8),
              // CustomTextField(
              //   validator: (value) =>
              //       value == null || value.isEmpty ? "Required" : null,
              //   keyboardType: TextInputType.text,
              //   hint: locale.anyChallengesFaced,
              //   controller: _challengesCtrl,
              //   maxLines: 4,
              // ),
              // const SizedBox(height: 26),

              // //! Lessons Learned
              // _buildLabel(locale.lessonsLearned),

              // const SizedBox(height: 8),
              // CustomTextField(
              //   validator: (value) =>
              //       value == null || value.isEmpty ? "Required" : null,
              //   keyboardType: TextInputType.text,
              //   hint: locale.lessonsLearned,
              //   controller: _lessonsCtrl,
              //   maxLines: 4,
              // ),
              // const SizedBox(height: 26),
              //! mode changer
              _buildLabel(locale.modeChanger),
               Switch(
                              value: selectedMode,
                              onChanged: (value) {
                                setState(() {
                                  selectedMode = value;
                                });
                              },
                              activeThumbColor: AppColors.primary,
                            ),
              if(selectedMode == true)
              MediaSection(
                onImagesChanged: (paths) {
                  setState(() {
                    _imagePaths = paths;
                  });
                },
                onVideosChanged: (paths) {
                  setState(() {
                    _videoPaths = paths;
                  });
                },
                onVoicesChanged: (paths) {
                  setState(() {
                    _voicePaths = paths;
                  });
                },
              ),
              const SizedBox(height: 26),

              //! Submit Button
              CustomSubmitButton(
                isLoading: state is ReportCreating,
                isEndable: _isFormComplete,
                onTap: _handleSubmit,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCountryDropdown() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppThemeConsts.padding16md,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.lightGray,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
        border: selectedCountryId == null
            ? Border.all(color: Colors.transparent)
            : Border.all(color: AppColors.primary, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
          value: selectedCountryId,
          isExpanded: true,
          dropdownColor: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
          hint: Row(
            children: [
              Icon(
                Icons.public_outlined,
                color: isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.mediumGray,
              ),
              const SizedBox(width: 10),
              Text(
                'Select Country',
                style: TextStyle(
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.mediumGray,
                ),
              ),
            ],
          ),
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
          items: _countries.map((country) {
            return DropdownMenuItem(
              //TODO: change this to work with CustomDropdown
              value: country.id,
              child: Row(
                children: [
                  const Icon(
                    Icons.public_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    country.nameEn,
                    style: TextStyle(
                      fontSize: 15,
                      color: isDarkMode
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: _onCountrySelected,
        ),
      ),
    );
  }

  Widget _buildCityDropdown() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isDisabled = selectedCountryId == null || _filteredCities.isEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppThemeConsts.padding16md,
      ),
      decoration: BoxDecoration(
        color: isDisabled
            ? (isDarkMode ? AppColors.cardElevatedDark : AppColors.borderLight)
            : (isDarkMode ? AppColors.cardDark : AppColors.lightGray),
        borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
        border: selectedCityId == null
            ? Border.all(color: Colors.transparent)
            : Border.all(color: AppColors.primary, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
          value: selectedCityId,
          isExpanded: true,
          dropdownColor: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
          hint: Row(
            children: [
              Icon(
                Icons.location_city_outlined,
                color: isDisabled
                    ? (isDarkMode
                          ? AppColors.textSecondaryDark.withAlpha(
                              (0.5 * 255).toInt(),
                            )
                          : Colors.grey[400])
                    : (isDarkMode
                          ? AppColors.textSecondaryDark
                          : AppColors.mediumGray),
              ),
              const SizedBox(width: 10),
              Text(
                selectedCountryId == null
                    ? 'Select country first'
                    : _filteredCities.isEmpty
                    ? 'No cities available'
                    : 'Select City',
                style: TextStyle(
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.mediumGray,
                ),
              ),
            ],
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: isDisabled
                ? (isDarkMode
                      ? AppColors.textSecondaryDark.withAlpha(
                          (0.5 * 255).toInt(),
                        )
                      : Colors.grey[400])
                : AppColors.primary,
          ),
          items: _filteredCities.map((city) {
            return DropdownMenuItem(
              value: city.id,
              child: Row(
                children: [
                  const Icon(
                    Icons.location_city_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      city.nameEn,
                      style: TextStyle(
                        fontSize: 15,
                        color: isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: isDisabled ? null : _onCitySelected,
        ),
      ),
    );
  }

  Widget _buildStadiumDropdown() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isDisabled = selectedCityId == null || _filteredStadiums.isEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppThemeConsts.padding16md,
      ),
      decoration: BoxDecoration(
        color: isDisabled
            ? (isDarkMode ? AppColors.cardElevatedDark : AppColors.borderLight)
            : (isDarkMode ? AppColors.cardDark : AppColors.lightGray),
        borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
        border: selectedStadiumId == null
            ? Border.all(color: Colors.transparent)
            : Border.all(color: AppColors.primary, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
          value: selectedStadiumId,
          isExpanded: true,
          dropdownColor: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
          hint: Row(
            children: [
              Icon(
                Icons.stadium_outlined,
                color: isDisabled
                    ? (isDarkMode
                          ? AppColors.textSecondaryDark.withAlpha(
                              (0.5 * 255).toInt(),
                            )
                          : Colors.grey[400])
                    : (isDarkMode
                          ? AppColors.textSecondaryDark
                          : AppColors.mediumGray),
              ),
              const SizedBox(width: 10),
              Text(
                selectedCityId == null
                    ? 'Select city first'
                    : _filteredStadiums.isEmpty
                    ? 'No stadiums available'
                    : 'Select Stadium',
                style: TextStyle(
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.mediumGray,
                ),
              ),
            ],
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: isDisabled
                ? (isDarkMode
                      ? AppColors.textSecondaryDark.withAlpha(
                          (0.5 * 255).toInt(),
                        )
                      : Colors.grey[400])
                : AppColors.primary,
          ),
          items: _filteredStadiums.map((stadium) {
            return DropdownMenuItem(
              value: stadium.id,
              child: Row(
                children: [
                  const Icon(
                    Icons.stadium_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      stadium.stadiumName,
                      style: TextStyle(
                        fontSize: 15,
                        color: isDarkMode
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: isDisabled ? null : _onStadiumSelected,
        ),
      ),
    );
  }

  Widget _buildAreaDropdown() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final areas = [
      {'value': 'westStand', 'label': 'West Stand'},
      {'value': 'eastStand', 'label': 'East Stand'},
      {'value': 'northStand', 'label': 'North Stand'},
      {'value': 'southStand', 'label': 'South Stand'},
      {'value': 'vip', 'label': 'VIP'},
      {'value': 'emergency', 'label': 'Emergency'},
      {'value': 'concourse', 'label': 'Concourse'},
      {'value': 'parkingArea', 'label': 'Parking Area'},
      {'value': 'mediaZone', 'label': 'Media Zone'},
      {'value': 'fieldLevel', 'label': 'Field Level'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppThemeConsts.padding16md,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.lightGray,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
        border: selectedArea == null
            ? Border.all(color: Colors.transparent)
            : Border.all(color: AppColors.primary, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
          value: selectedArea,
          isExpanded: true,
          dropdownColor: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
          hint: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.mediumGray,
              ),
              const SizedBox(width: 10),
              Text(
                'Select Area',
                style: TextStyle(
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.mediumGray,
                ),
              ),
            ],
          ),
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
          items: areas.map((area) {
            return DropdownMenuItem(
              value: area['value'],
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    area['label']!,
                    style: TextStyle(
                      fontSize: 15,
                      color: isDarkMode
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: _onAreaSelected,
        ),
      ),
    );
  }

  // Widget _buildTicketTypeDropdown() {
  //   final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  //   final ticketType = [
  //     {'value': 'positive', 'label': 'Positive'},
  //     {'value': 'negative', 'label': 'Negative'},
  //   ];

  //   return Container(
  //     padding: const EdgeInsets.symmetric(
  //       horizontal: AppThemeConsts.padding16md,
  //     ),
  //     decoration: BoxDecoration(
  //       color: isDarkMode ? AppColors.cardDark : AppColors.lightGray,
  //       borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
  //       border: selectedTicketType == null
  //           ? Border.all(color: Colors.transparent)
  //           : Border.all(color: AppColors.primary, width: 2),
  //     ),
  //     child: DropdownButtonHideUnderline(
  //       child: DropdownButton<String>(
  //         borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
  //         value: selectedTicketType,
  //         isExpanded: true,
  //         dropdownColor: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
  //         hint: Row(
  //           children: [
  //             Icon(
  //               Icons.edit_document,
  //               color: isDarkMode
  //                   ? AppColors.textSecondaryDark
  //                   : AppColors.mediumGray,
  //             ),
  //             const SizedBox(width: 10),
  //             Text(
  //               'Select Ticket Type',
  //               style: TextStyle(
  //                 color: isDarkMode
  //                     ? AppColors.textSecondaryDark
  //                     : AppColors.mediumGray,
  //               ),
  //             ),
  //           ],
  //         ),
  //         icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
  //         items: ticketType.map((type) {
  //           return DropdownMenuItem(
  //             value: type['value'],
  //             child: Row(
  //               children: [
  //                 const Icon(
  //                   Icons.edit_document,
  //                   color: AppColors.primary,
  //                   size: 20,
  //                 ),
  //                 const SizedBox(width: 10),
  //                 Text(
  //                   type['label']!,
  //                   style: TextStyle(
  //                     fontSize: 15,
  //                     color: isDarkMode
  //                         ? AppColors.textPrimaryDark
  //                         : AppColors.textPrimaryLight,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         }).toList(),
  //         onChanged: _onTicketTypeSelected,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildModelTypeDropdown() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final modelType = [
      {'value': 'visualPollution', 'label': 'Visual Pollution'},
      {'value': 'safety', 'label': 'Safety'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppThemeConsts.padding16md,
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.cardDark : AppColors.lightGray,
        borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
        border: selectedModelType == null
            ? Border.all(color: Colors.transparent)
            : Border.all(color: AppColors.primary, width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(AppThemeConsts.radius12md),
          value: selectedModelType,
          isExpanded: true,
          dropdownColor: isDarkMode ? AppColors.cardDark : AppColors.whiteColor,
          hint: Row(
            children: [
              Icon(
                Icons.model_training_rounded,
                color: isDarkMode
                    ? AppColors.textSecondaryDark
                    : AppColors.mediumGray,
              ),
              const SizedBox(width: 10),
              Text(
                'Select Model Type',
                style: TextStyle(
                  color: isDarkMode
                      ? AppColors.textSecondaryDark
                      : AppColors.mediumGray,
                ),
              ),
            ],
          ),
          icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
          items: modelType.map((type) {
            return DropdownMenuItem(
              value: type['value'],
              child: Row(
                children: [
                  const Icon(
                    Icons.model_training_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    type['label']!,
                    style: TextStyle(
                      fontSize: 15,
                      color: isDarkMode
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: _onModelTypeSelected,
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: isDarkMode
            ? AppColors.textPrimaryDark
            : AppColors.textPrimaryLight,
      ),
    );
  }
}
