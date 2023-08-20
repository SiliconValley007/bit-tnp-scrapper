import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnp_scanner/constants/constants.dart';
import 'package:tnp_scanner/pages/home/model/job_detail_argument.dart';
import 'package:url_launcher/url_launcher.dart';

import '../cubits/job_details_cubit/job_details_cubit.dart';
import '../models/job_details/salary_details.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key, required this.job});

  final JobDetailArgument job;

  static Route route({required JobDetailArgument id}) =>
      MaterialPageRoute<void>(
        builder: (_) => JobDetailsScreen(
          job: id,
        ),
      );

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<JobDetailsCubit>().getJobDetails(widget.job.jobId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<JobDetailsCubit, JobDetailsState>(
          builder: (context, state) {
            if (state is JobDetailsLoaded) {
              return ListView(
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    widget.job.companyName,
                    style: const TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _PostedByDetails(
                    postedBy: state.details.postedBy,
                  ),
                  const SizedBox(height: 24),
                  const _Heading('Registration'),
                  const SizedBox(height: 16),
                  _CustomText(
                    descriptor:
                        "${state.details.registrationDetails.startsFrom.split(': ').first} - ",
                    value: state.details.registrationDetails.startsFrom
                        .split(': ')
                        .last,
                  ),
                  const SizedBox(height: 8),
                  _CustomText(
                    descriptor:
                        "${state.details.registrationDetails.endsOn.split(': ').first} - ",
                    value: state.details.registrationDetails.endsOn
                        .split(': ')
                        .last,
                  ),
                  const SizedBox(height: 24),
                  const _Heading('Job Profile Details'),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          offWhite,
                          Colors.deepPurple.withOpacity(0.3),
                        ],
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: const Text(
                      'Full Time Employment',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _CustomText(
                    descriptor: 'Job Designation - ',
                    value: state.details.jobProfileDetails.fullTimeEmployment
                        .jobDesignation,
                  ),
                  const SizedBox(height: 8),
                  _CustomText(
                    descriptor: 'Type - ',
                    value:
                        state.details.jobProfileDetails.fullTimeEmployment.type,
                  ),
                  const SizedBox(height: 8),
                  _CustomText(
                    descriptor: 'Job Description - ',
                    value: state.details.jobProfileDetails.fullTimeEmployment
                        .jobDescription,
                  ),
                  const SizedBox(height: 8),
                  if (state.details.jobProfileDetails.fullTimeEmployment
                      .jobDescriptionLink.isNotEmpty)
                    GestureDetector(
                      onTap: () => launchUrl(Uri.parse(baseUrl +
                          filterUrl(state.details.jobProfileDetails
                              .fullTimeEmployment.jobDescriptionLink))),
                      child: const Text(
                        'Attached Document',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  if (state.details.jobProfileDetails.fullTimeEmployment
                      .jobDescriptionLink.isNotEmpty)
                    const SizedBox(height: 8),
                  _CustomText(
                    descriptor: 'Place of posting - ',
                    value: state.details.jobProfileDetails.fullTimeEmployment
                        .placeOfPosting,
                  ),
                  const SizedBox(height: 14),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          offWhite,
                          Colors.deepPurple.withOpacity(0.3),
                        ],
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: const Text(
                      'Internship',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _CustomText(
                    descriptor: 'Job Designation - ',
                    value: state
                        .details.jobProfileDetails.internship.jobDesignation,
                  ),
                  const SizedBox(height: 8),
                  _CustomText(
                    descriptor: 'Job Description - ',
                    value: state
                        .details.jobProfileDetails.internship.jobDescription,
                  ),
                  const SizedBox(height: 8),
                  if (state.details.jobProfileDetails.internship
                      .jobDescriptionLink.isNotEmpty)
                    GestureDetector(
                      onTap: () => launchUrl(Uri.parse(baseUrl +
                          filterUrl(state.details.jobProfileDetails.internship
                              .jobDescriptionLink))),
                      child: const Text(
                        'Attached Document',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  if (state.details.jobProfileDetails.fullTimeEmployment
                      .jobDescriptionLink.isNotEmpty)
                    const SizedBox(height: 8),
                  _CustomText(
                    descriptor: 'Place of posting - ',
                    value: state.details.jobProfileDetails.fullTimeEmployment
                        .placeOfPosting,
                  ),
                  const SizedBox(height: 24),
                  const _Heading('Salary Details - FTE'),
                  const SizedBox(height: 16),
                  _SalaryDetails(salaryDetails: state.details.salaryDetails),
                  const SizedBox(height: 16),
                  _CustomText(
                    descriptor: 'Remarks: ',
                    value: state.details.salaryDetailsRemarks,
                  ),
                  const SizedBox(height: 24),
                  const _Heading('Stipend Details - Internship'),
                  const SizedBox(height: 16),
                  _CustomText(
                    descriptor: 'PG - ',
                    value: state.details.stipendDetails.pg,
                  ),
                  const SizedBox(height: 4),
                  _CustomText(
                    descriptor: 'pg benefits - ',
                    value: state.details.stipendDetails.pgBenefits,
                  ),
                  const SizedBox(height: 12),
                  _CustomText(
                    descriptor: 'UG - ',
                    value: state.details.stipendDetails.ug,
                  ),
                  const SizedBox(height: 4),
                  _CustomText(
                    descriptor: 'ug benefits - ',
                    value: state.details.stipendDetails.ugBenefits,
                  ),
                  const SizedBox(height: 24),
                  const _Heading('Selection Process'),
                  const SizedBox(height: 16),
                  _SelectionProcess(
                    selectionProcess: state.details.selectionProcess,
                  ),
                  const SizedBox(height: 24),
                  const _Heading('Eligibility'),
                  const SizedBox(height: 16),
                  _EligibleCourses(
                    courses: state.details.eligibility.courses,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Criteria',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _CustomText(
                    descriptor: '10th - ',
                    value: state.details.eligibility.criteria.tenth,
                  ),
                  const SizedBox(height: 8),
                  _CustomText(
                    descriptor: '12th - ',
                    value: state.details.eligibility.criteria.twelfth,
                  ),
                  const SizedBox(height: 8),
                  _CustomText(
                    descriptor: 'UG - ',
                    value: state.details.eligibility.criteria.ug,
                  ),
                  const SizedBox(height: 8),
                  _CustomText(
                    descriptor: 'PG - ',
                    value: state.details.eligibility.criteria.pg,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Other criteria',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _OtherCriteria(
                    otherCriteria: cleanText(
                        state.details.eligibility.criteria.otherCriteria),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Additional criteria',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.details.eligibility.additionalCriteria,
                  ),
                  const SizedBox(height: 24),
                  const _Heading('Company Details'),
                  const SizedBox(height: 16),
                  _CustomText(
                    descriptor: 'Description - ',
                    value: state.details.companyDetails.description,
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => launchUrl(
                      Uri.parse(state.details.companyDetails.url),
                    ),
                    child: Text.rich(
                      TextSpan(
                        text: 'URL - ',
                        children: [
                          TextSpan(
                            text: state.details.companyDetails.url,
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is JobDetailsError) {
              return Center(
                child: Text(state.message ?? ''),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class _SalaryDetails extends StatelessWidget {
  const _SalaryDetails({
    required this.salaryDetails,
  });

  final SalaryDetails salaryDetails;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      children: [
        const TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('       '),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'UG',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'PG',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'CTC',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(salaryDetails.ctc.first),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(salaryDetails.ctc.last),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Basic Pay',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(salaryDetails.basicPay.first),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(salaryDetails.basicPay.last),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Joining/Retention Bonus',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(salaryDetails.joiningBonus.first),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(salaryDetails.joiningBonus.last),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'RSU',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(salaryDetails.rsu.first),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(salaryDetails.rsu.last),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'ESOP',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(salaryDetails.esop.first),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(salaryDetails.esop.last),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Other benefits',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(salaryDetails.otherBenefits.first),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(salaryDetails.otherBenefits.last),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OtherCriteria extends StatelessWidget {
  const _OtherCriteria({
    required this.otherCriteria,
  });

  final List<String> otherCriteria;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Text(otherCriteria[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 4),
      itemCount: otherCriteria.length,
    );
  }
}

class _EligibleCourses extends StatelessWidget {
  const _EligibleCourses({
    required this.courses,
  });

  final List<String> courses;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: index % 2 == 0 ? Colors.white : Colors.deepPurple,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        padding: const EdgeInsets.all(8),
        child: Text(
          courses[index],
          style: TextStyle(
            color: index % 2 == 0 ? Colors.deepPurple : Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: courses.length,
    );
  }
}

class _SelectionProcess extends StatelessWidget {
  const _SelectionProcess({
    required this.selectionProcess,
  });

  final List<String> selectionProcess;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Text(
        selectionProcess[index],
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: selectionProcess.length,
    );
  }
}

class _PostedByDetails extends StatelessWidget {
  const _PostedByDetails({
    required this.postedBy,
  });

  final String postedBy;

  @override
  Widget build(BuildContext context) {
    final List<String> details = postedBy.split("||");
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Text(
        details[index],
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: details.length,
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.deepPurpleAccent,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}

class _CustomText extends StatelessWidget {
  const _CustomText({
    required this.descriptor,
    required this.value,
  });

  final String descriptor;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: descriptor,
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
