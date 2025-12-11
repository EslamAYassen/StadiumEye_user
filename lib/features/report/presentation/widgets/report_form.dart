import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stadium_eye/core/widgets/loading/lottie_loading.dart';
import 'package:stadium_eye/features/report/presentation/bloc/report_event.dart';

import 'package:stadium_eye/features/report/presentation/widgets/custom_submit_button.dart';
import 'package:stadium_eye/features/report/presentation/widgets/media_section.dart';
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
  final _challengesCtrl = TextEditingController();
  final _lessonsCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Selected values
  String? selectedCountryId;
  String? selectedCityId;
  String? selectedStadiumId;
  String? selectedArea;
  String? selectedTicketType;

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

  @override
  void initState() {
    super.initState();
    // Load countries first
    context.read<ReportsBloc>().add(const LoadCountriesEvent());
  }

  @override
  void dispose() {
    _observationsCtrl.dispose();
    _challengesCtrl.dispose();
    _lessonsCtrl.dispose();
    super.dispose();
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
  }

  void _onStadiumSelected(String? stadiumId) {
    setState(() {
      selectedStadiumId = stadiumId;
    });
  }

  void _onAreaSelected(String? area) {
    setState(() {
      selectedArea = area;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
          setState(() {
            _isLoadingCountries = false;
            _isLoadingCities = false;
            _isLoadingStadiums = false;
          });
        } else if (state is ReportCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
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
              const Text(
                "Country *",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _isLoadingCountries
                  ? const Center(
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: LottieLoader(),
                      ),
                    )
                  : _buildCountryDropdown(),
              const SizedBox(height: 26),

              //! City Dropdown
              const Text(
                "City *",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _isLoadingCities
                  ? const Center(
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: LottieLoader(),
                      ),
                    )
                  : _buildCityDropdown(),
              const SizedBox(height: 26),

              //! Stadium Dropdown
              const Text(
                "Stadium *",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _isLoadingStadiums
                  ? const Center(
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: LottieLoader(),
                      ),
                    )
                  : _buildStadiumDropdown(),
              const SizedBox(height: 26),

              //! Area Dropdown
              const Text(
                "Area *",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _buildAreaDropdown(),
              const SizedBox(height: 26),

              //! Ticket Type Dropdown
              const Text(
                "Ticket Type *",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              _buildTicketTypeDropdown(),
              const SizedBox(height: 26),

              //! Observations
              const Text(
                "Observations *",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
                keyboardType: TextInputType.text,
                controller: _observationsCtrl,
                hint: "Describe your observations here...",
                maxLines: 5,
              ),
              const SizedBox(height: 26),

              //! Challenges
              const Text(
                "Challenges *",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
                keyboardType: TextInputType.text,
                hint: "Any challenges faced...",
                controller: _challengesCtrl,
                maxLines: 4,
              ),
              const SizedBox(height: 26),

              //! Lessons Learned
              const Text(
                "Lessons Learned *",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
                keyboardType: TextInputType.text,
                hint: "Key takeaways...",
                controller: _lessonsCtrl,
                maxLines: 4,
              ),
              const SizedBox(height: 26),

              //! Media Section
              MediaSection(
                onPhotoUpload: () {},
                onVideoUpload: () {},
                onVoiceRecord: () {},
              ),
              const SizedBox(height: 26),

              //! Submit Button
              CustomSubmitButton(
                isLoading: state is ReportsLoading,
                isEndable:
                    _formKey.currentState!.validate() &&
                    selectedStadiumId != null &&
                    selectedArea != null &&
                    selectedTicketType != null &&
                    _observationsCtrl.text.isNotEmpty,
                onTap: () => context.read<ReportsBloc>().add(
                  CreateReportEvent(
                    CreateReportParams(
                      stadiumId: selectedStadiumId ?? '',
                      area: selectedArea ?? '',
                      ticketType: selectedTicketType ?? '',
                      //TODO: change this
                      modelType: "visualPollution",

                      observations: _observationsCtrl.text,
                      challenges: _challengesCtrl.text,
                      lessonsLearned: _lessonsCtrl.text,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCountryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(15),
        border: selectedCountryId == null
            ? Border.all(color: Colors.transparent)
            : Border.all(color: const Color(0xFF00C853), width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCountryId,
          isExpanded: true,
          hint: Row(
            children: [
              const Icon(Icons.public_outlined, color: Colors.grey),
              const SizedBox(width: 10),
              Text('Select Country', style: TextStyle(color: Colors.grey[400])),
            ],
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF00C853)),
          items: _countries.map((country) {
            return DropdownMenuItem(
              value: country.id,
              child: Row(
                children: [
                  const Icon(
                    Icons.public_outlined,
                    color: Color(0xFF00C853),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    country.nameEn,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF022C0C),
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
    final isDisabled = selectedCountryId == null || _filteredCities.isEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDisabled ? Colors.grey[200] : const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(15),
        border: selectedCityId == null
            ? Border.all(color: Colors.transparent)
            : Border.all(color: const Color(0xFF00C853), width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCityId,
          isExpanded: true,
          hint: Row(
            children: [
              Icon(
                Icons.location_city_outlined,
                color: isDisabled ? Colors.grey[400] : Colors.grey,
              ),
              const SizedBox(width: 10),
              Text(
                selectedCountryId == null
                    ? 'Select country first'
                    : _filteredCities.isEmpty
                    ? 'No cities available'
                    : 'Select City',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ],
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: isDisabled ? Colors.grey[400] : const Color(0xFF00C853),
          ),
          items: _filteredCities.map((city) {
            return DropdownMenuItem(
              value: city.id,
              child: Row(
                children: [
                  const Icon(
                    Icons.location_city_outlined,
                    color: Color(0xFF00C853),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      city.nameEn,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF022C0C),
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
    final isDisabled = selectedCityId == null || _filteredStadiums.isEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDisabled ? Colors.grey[200] : const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(15),
        border: selectedStadiumId == null
            ? Border.all(color: Colors.transparent)
            : Border.all(color: const Color(0xFF00C853), width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedStadiumId,
          isExpanded: true,
          hint: Row(
            children: [
              Icon(
                Icons.stadium_outlined,
                color: isDisabled ? Colors.grey[400] : Colors.grey,
              ),
              const SizedBox(width: 10),
              Text(
                selectedCityId == null
                    ? 'Select city first'
                    : _filteredStadiums.isEmpty
                    ? 'No stadiums available'
                    : 'Select Stadium',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ],
          ),
          icon: Icon(
            Icons.arrow_drop_down,
            color: isDisabled ? Colors.grey[400] : const Color(0xFF00C853),
          ),
          items: _filteredStadiums.map((stadium) {
            return DropdownMenuItem(
              value: stadium.id,
              child: Row(
                children: [
                  const Icon(
                    Icons.stadium_outlined,
                    color: Color(0xFF00C853),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      stadium.stadiumName,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF022C0C),
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
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(15),
        border: selectedArea == null
            ? Border.all(color: Colors.transparent)
            : Border.all(color: const Color(0xFF00C853), width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedArea,
          isExpanded: true,
          hint: Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.grey),
              const SizedBox(width: 10),
              Text('Select Area', style: TextStyle(color: Colors.grey[400])),
            ],
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF00C853)),
          items: areas.map((area) {
            return DropdownMenuItem(
              value: area['value'],
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF00C853),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    area['label']!,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF022C0C),
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

  Widget _buildTicketTypeDropdown() {
    final ticketType = [
      {'value': 'positive', 'label': 'Positive'},
      {'value': 'negative', 'label': 'Negative'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(15),
        border: selectedTicketType == null
            ? Border.all(color: Colors.transparent)
            : Border.all(color: const Color(0xFF00C853), width: 2),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedTicketType,
          isExpanded: true,
          hint: Row(
            children: [
              const Icon(Icons.edit_document, color: Colors.grey),
              const SizedBox(width: 10),
              Text(
                'Select Ticket Type',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ],
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF00C853)),
          items: ticketType.map((type) {
            return DropdownMenuItem(
              value: type['value'],
              child: Row(
                children: [
                  const Icon(
                    Icons.edit_document,
                    color: Color(0xFF00C853),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    type['label']!,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF022C0C),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (val) => setState(() => selectedTicketType = val),
        ),
      ),
    );
  }
}
