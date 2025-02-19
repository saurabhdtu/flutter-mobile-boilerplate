import 'dart:convert';

import 'package:common_module/fresh_chat.dart';
import 'package:common_module/model/faq_support.dart';
import 'package:common_module/remote_config.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_image.dart';
import 'package:design_module/widget/zinc_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zinc/app/router.dart';
import 'package:zinc/core/application/application_bloc.dart';
import 'package:zinc/core/help_and_support/bloc/help_support_bloc.dart';
import 'package:zinc/core/help_and_support/bloc/help_support_state.dart';
import 'package:zinc/core/help_and_support/repo/tickets_model.dart';
import 'package:zinc/core/help_and_support/repo/tickets_repo.dart';
import 'package:zinc/core/help_and_support/view/crousel_video_player.dart';
import 'package:zinc/core/help_and_support/view/footer_widget.dart';
import 'package:zinc/core/help_and_support/view/tickets_widgets.dart';
import 'package:zinc/constants/strings.dart';
import 'package:zinc/lob/remittance/common/scaffold.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupportPage extends StatefulWidget {
  static const _pageName = "customer_support_screen";
  @override
  _SupportPageState createState() => _SupportPageState();

  const SupportPage() : super(key: const ValueKey(_pageName));
}

class _SupportPageState extends State<SupportPage> {
  SupportFaq _supportFaq = SupportFaq(faq: [], videos: []);

  @override
  void initState() {
    super.initState();
    initRemoteConfig();
  }

  Future<void> initRemoteConfig() async {
    if (mounted) {
      setState(() {
        _supportFaq = RemoteConfigManager.getInstance.getJsonData<SupportFaq>(
          RemoteConfigKeys.supportFaq,
          (p0) => SupportFaq.fromJson(p0),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZincScaffold.scaffold(context, '', _getContent(), showHelp: false);
  }

  Widget _getContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 20),
                VideoCarousel(videos: _supportFaq.videos),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                _buildFaqSection(),
                const SizedBox(height: 20),
                GestureDetector(
                  child: ZincImage.imageAsset(
                    imageName: "chat_with_us.webp",
                    isCircle: false,
                  ),
                  onTap: () {
                    FreshchatService.showConversation();
                  },
                ),
                const SizedBox(height: 20),
                ListTile(
                  onTap: () async {
                    await launchUrl(
                        Uri.parse(ApplicationBloc.appURLs.contactNum ?? ""));
                  },
                  leading: ZincImage.imageAsset(
                      isCircle: false, imageName: "call.png"),
                  title: Text(
                    AppStrings.callUs,
                    style: ZincTextStyle.largeExtraBold(),
                  ),
                  subtitle: Text(
                    AppStrings.ourExpertWillGuideYou,
                    style: ZincTextStyle.normalRegular(),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
          const CustomFooter()
        ],
      ),
    );
  }

  Widget _buildTicketSection(List<Ticket> tickets) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.currentTicket,
              style: ZincTextStyle.largeExtraBold(),
            ),
            GestureDetector(
              child: Text(
                AppStrings.viewAll,
                style: ZincTextStyle.normalBold(color: Colors.green),
              ),
              onTap: () {
                String encodedTickets =
                    jsonEncode(tickets.map((e) => e.toJson()).toList());

                context.pushNamed(
                  CommonRoutes.ticketDetailsView,
                  pathParameters: {
                    'data': encodedTickets,
                  },
                );
              },
            ),
          ],
        ),
        TicketListWidget(
          tickets,
          ticketsLength: 1,
        ),
      ],
    );
  }

  Widget _buildFaqSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.topFaqs,
              style: ZincTextStyle.largeExtraBold(),
            ),
            GestureDetector(
              child: Text(
                AppStrings.viewAll,
                style: ZincTextStyle.normalBold(color: Colors.green),
              ),
              onTap: () {
                FreshchatService.showFAQ();
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        ..._supportFaq.faq.map((faq) {
          return Column(
            children: [
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                shape: Border(),
                trailing: Container(
                  width: 35.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 25.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                title: Text(
                  faq.question,
                  style: ZincTextStyle.normalBold(),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      faq.answer,
                      style: ZincTextStyle.normalRegular(),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey.withOpacity(0.1),
                thickness: 3,
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}
