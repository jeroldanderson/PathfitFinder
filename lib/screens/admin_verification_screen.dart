import 'package:flutter/material.dart';

import '../dataconnect_generated/generated.dart';
import '../theme.dart';
import '../widgets/shared.dart';

/// Automatically gets access to the In-App Admin Verification Panel.
const Set<String> kAdminEmails = {
  'jonathandwayne.decastro.cics@ust.edu.ph',
  'jeroldandre.deguzman.cics@ust.edu.ph',
  'jaycee.delarosa.cics@ust.edu.ph',
  'vincentelbert.venancio.cics@ust.edu.ph',
  'johnmatthew.kong.cics@ust.edu.ph'
};

class AdminVerificationScreen extends StatefulWidget {
  const AdminVerificationScreen({super.key});

  @override
  State<AdminVerificationScreen> createState() =>
      _AdminVerificationScreenState();
}

class _AdminVerificationScreenState extends State<AdminVerificationScreen> {
  bool _loading = true;
  String? _processingId;
  List<GetPendingVerificationsVerificationSubmissions> _pending = [];

  @override
  void initState() {
    super.initState();
    _loadPending();
  }

  Future<void> _loadPending() async {
    setState(() => _loading = true);
    try {
      final res = await ExampleConnector.instance
          .getPendingVerifications()
          .execute();
      if (mounted) {
        setState(() => _pending = res.data.verificationSubmissions);
      }
    } catch (_) {
      if (mounted) {
        showNotice(context, 'Could not load pending verifications.');
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _review(
    GetPendingVerificationsVerificationSubmissions item,
    VerificationStatus status,
  ) async {
    if (_processingId != null) return;
    setState(() => _processingId = item.id);
    try {
      await ExampleConnector.instance
          .reviewVerificationSubmission(
            userId: item.user.id,
            submissionId: item.id,
            status: status,
          )
          .execute();
      if (mounted) {
        setState(() => _pending.removeWhere((e) => e.id == item.id));
        showNotice(
          context,
          status == VerificationStatus.VERIFIED
              ? '${item.user.fullName} approved as Verified Thomasian.'
              : '${item.user.fullName} verification rejected.',
        );
      }
    } catch (_) {
      if (mounted) {
        showNotice(context, 'Action failed. Please try again.');
      }
    } finally {
      if (mounted) setState(() => _processingId = null);
    }
  }

  void _inspectDocument(String title, String imageUrl) {
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Photo(
                    imageUrl,
                    width: double.infinity,
                    height: 360,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pinch to zoom in on UST ID / Registration Form details.',
                style: TextStyle(fontSize: 11, color: muted),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin · ID Verifications'),
        actions: [
          IconButton(
            tooltip: 'Refresh list',
            onPressed: _loading ? null : _loadPending,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: ink,
          backgroundColor: Colors.white,
          onRefresh: _loadPending,
          child: PageBody(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pending Thomasian Accounts',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Inspect the uploaded UST ID or Registration Form before granting full marketplace access.',
                  style: TextStyle(fontSize: 12, color: muted),
                ),
                const SizedBox(height: 20),
                if (_loading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 60),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (_pending.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 60),
                    child: Center(
                      child: Text(
                        'All caught up! No pending verifications right now.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  ..._pending.map((item) {
                    final isBusy = _processingId == item.id;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        border: Border.all(color: line),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.user.fullName,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.user.email,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: muted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: cream,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'PENDING',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: () => _inspectDocument(
                              item.user.fullName,
                              item.documentUrl,
                            ),
                            child: Stack(
                              children: [
                                Photo(
                                  item.documentUrl,
                                  width: double.infinity,
                                  height: 170,
                                  radius: 12,
                                ),
                                Positioned(
                                  right: 10,
                                  bottom: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ink.withValues(alpha: 0.8),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.zoom_in,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Tap to zoom',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: isBusy
                                      ? null
                                      : () => _review(
                                            item,
                                            VerificationStatus.REJECTED,
                                          ),
                                  child: const Text('Reject'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: PrimaryButton(
                                  'Approve',
                                  loading: isBusy,
                                  onPressed: () => _review(
                                    item,
                                    VerificationStatus.VERIFIED,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}