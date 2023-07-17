import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/src/controller/proposal_controller.dart';
import 'package:akij_login_app/src/view/components/build_title_section.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:akij_login_app/src/view/components/custom_text_field.dart';
import 'package:akij_login_app/src/view/components/custom_text_styles.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/constants/app_asset.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/src/view/screen/proposal_list/filter_proposal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProposalListScreen extends StatelessWidget {
  const ProposalListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final proposalController = Get.put(ProposalController());

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
          backgroundColor: AppColors.secBgColor,
          appBar: const BaseAppBar(title: 'Proposal List'),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Container(
                //   padding: const EdgeInsets.only(
                //       left: 15, right: 15, top: 13, bottom: 10),
                //   color: Colors.white,
                //   child: Material(
                //     shape: RoundedRectangleBorder(
                //       borderRadius:
                //           BorderRadius.circular(AppSize.textFieldBorderRadius),
                //     ),
                //     elevation: 0,
                //     child: SizedBox(
                //       width: MediaQuery.of(context).size.width,
                //       child: TextButton(
                //         style: TextButton.styleFrom(
                //           padding: EdgeInsets.symmetric(
                //               vertical:
                //                   MediaQuery.of(context).size.height * 0.015),
                //           shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(
                //                   AppSize.textFieldBorderRadius)),
                //           foregroundColor: Colors.white,
                //           backgroundColor: Colors.grey.shade200,
                //         ),
                //         onPressed: () {
                //           showModalBottomSheet(
                //               backgroundColor: Colors.transparent,
                //               isScrollControlled: true,
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return FilterProposal(
                //                   codeController:
                //                       proposalController.codeEditingController,
                //                   proposalNoController: proposalController
                //                       .proposaltEditingController,
                //                   function: () {
                //                     proposalController.callForProposalList();
                //                   },
                //                 );
                //               });
                //         },
                //         child: Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               SvgPicture.asset(
                //                 AppAsset.search,
                //                 height: AppSize.iconHeight,
                //                 width: AppSize.iconWidth,
                //               ),
                //               const SizedBox(width: 10),
                //               Text(
                //                 "Search",
                //                 style: TextStyle(
                //                     fontSize:
                //                         MediaQuery.of(context).size.width *
                //                             0.035,
                //                     fontWeight: FontWeight.w600,
                //                     color: Colors.grey.shade600),
                //               ),
                //             ]),
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: AppSize.sizedBoxHeight,
                ),
                CustomTextField(
                    hintText: "Enter Code",
                    controller: proposalController.codeEditingController,
                    icon: Icons.note),
                const SizedBox(
                  height: AppSize.sizedBoxHeight,
                ),
                CustomTextField(
                    hintText: "Enter Proposal No",
                    controller: proposalController.proposaltEditingController,
                    icon: Icons.edit_note_rounded),
                LargeButton(
                  btnText: "Search",
                  onPressed: () => proposalController.callForProposalList(),
                ),
                Obx(
                  () => proposalController.initialScreen.value
                      ? Container()
                      : proposalController.dataLoading.value
                          ? const CustomCircularProgress()
                          : Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DataTable(
                                          columns: [
                                            DataColumn(
                                                label: Text(
                                              "Payment",
                                              style: CustomTextStyles
                                                  .tableHeaderStyle(context),
                                            )),
                                            DataColumn(
                                              label: Text(
                                                "Proposal No",
                                                style: CustomTextStyles
                                                    .tableHeaderStyle(context),
                                              ),
                                            ),
                                            DataColumn(
                                                label: Text(
                                              "Name",
                                              style: CustomTextStyles
                                                  .tableHeaderStyle(context),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              "Com Date",
                                              style: CustomTextStyles
                                                  .tableHeaderStyle(context),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              "FA",
                                              style: CustomTextStyles
                                                  .tableHeaderStyle(context),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              "UND Requirements",
                                              style: CustomTextStyles
                                                  .tableHeaderStyle(context),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              "Medical Dr Decision",
                                              style: CustomTextStyles
                                                  .tableHeaderStyle(context),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              "Underwriting Decision",
                                              style: CustomTextStyles
                                                  .tableHeaderStyle(context),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              "Submitted By",
                                              style: CustomTextStyles
                                                  .tableHeaderStyle(context),
                                            )),
                                            DataColumn(
                                                label: Text(
                                              "Status",
                                              style: CustomTextStyles
                                                  .tableHeaderStyle(context),
                                            )),
                                          ],
                                          rows: proposalController.proposalsList
                                              .map(
                                                (proposal) => DataRow(cells: [
                                                  DataCell(
                                                    TextButton(
                                                      onPressed: () {
                                                        proposalController
                                                                .proposalNo
                                                                .value =
                                                            proposal.proposalno
                                                                .toString();
                                                        proposalController
                                                            .payProposal(
                                                                context,
                                                                proposalController
                                                                    .proposalNo
                                                                    .value);
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                        foregroundColor:
                                                            Colors.white,
                                                        backgroundColor:
                                                            AppColors.butCol,
                                                        disabledForegroundColor:
                                                            Colors.grey
                                                                .withOpacity(
                                                                    0.38),
                                                      ),
                                                      child: const Text(
                                                        "Pay",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(Text(proposal
                                                      .proposalno
                                                      .toString())),
                                                  DataCell(Text(proposal
                                                      .proposersName
                                                      .toString())),
                                                  DataCell(Text(proposal.comdate
                                                      .toString())),
                                                  DataCell(Text(proposal.tayer1
                                                      .toString())),
                                                  DataCell(Text(proposal
                                                      .uNDRequirment
                                                      .toString())),
                                                  DataCell(Text(proposal
                                                      .medicalDrDecission
                                                      .toString())),
                                                  DataCell(Text(proposal
                                                      .underwritingDecission
                                                      .toString())),
                                                  DataCell(Text(proposal
                                                      .logInUserName
                                                      .toString())),
                                                  DataCell(Text(proposal.status
                                                      .toString())),
                                                ]),
                                              )
                                              .toList(),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                ),
              ],
            ),
          )),
    );
  }
}
