import 'package:flutter/material.dart';
import 'package:inflow/core/app_theme.dart';

class InvoicesTab extends StatefulWidget {
  const InvoicesTab({super.key});

  @override
  State<InvoicesTab> createState() => _InvoicesTabState();
}

class _InvoicesTabState extends State<InvoicesTab> {
  String _activeFilter = 'All';

  final List<Map<String, String>> _allInvoices = [
    {'client': 'TechCorp Solutions', 'amount': '\$4,500', 'date': '20 May 2026', 'status': 'Pending'},
    {'client': 'Design Studio', 'amount': '\$1,200', 'date': '15 May 2026', 'status': 'Paid'},
    {'client': 'Global Marketing', 'amount': '\$3,850', 'date': '10 May 2026', 'status': 'Overdue'},
    {'client': 'Local Bakery', 'amount': '\$450', 'date': '01 May 2026', 'status': 'Paid'},
    {'client': 'Startup X', 'amount': '\$2,100', 'date': '25 Apr 2026', 'status': 'Paid'},
  ];

  List<Map<String, String>> get _filteredInvoices {
    if (_activeFilter == 'All') return _allInvoices;
    return _allInvoices.where((inv) => inv['status'] == _activeFilter).toList();
  }

  void _showCreateInvoiceForm() {
    final clientController = TextEditingController();
    final amountController = TextEditingController();
    final dateController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 24, left: 24, right: 24,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Create New Invoice', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              TextFormField(
                controller: clientController,
                decoration: const InputDecoration(hintText: 'Client Name'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Amount (\$)'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(hintText: 'Due Date (e.g. 1st June 2026)'),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (clientController.text.isNotEmpty && amountController.text.isNotEmpty) {
                    setState(() {
                      _allInvoices.insert(0, {
                        'client': clientController.text,
                        'amount': '\$${amountController.text}',
                        'date': dateController.text.isEmpty ? 'Just now' : dateController.text,
                        'status': 'Pending',
                      });
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Invoice created successfully!')),
                    );
                  }
                },
                child: const Text('Create Invoice'),
              ),
              const SizedBox(height: 48),
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
        title: const Text('Invoices'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: Column(
        children: [
          // Header Actions
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton.icon(
              onPressed: _showCreateInvoiceForm,
              icon: const Icon(Icons.add_rounded),
              label: const Text('New Invoice'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 4,
                shadowColor: AppColors.primary.withOpacity(0.3),
              ),
            ),
          ),
          
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: ['All', 'Paid', 'Pending', 'Overdue'].map((filter) {
                final isSelected = _activeFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: ChoiceChip(
                    label: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                      child: Text(filter, style: TextStyle(color: isSelected ? Colors.white : AppColors.textDim, fontWeight: FontWeight.bold)),
                    ),
                    selected: isSelected,
                    onSelected: (val) => setState(() => _activeFilter = filter),
                    backgroundColor: Theme.of(context).cardTheme.color,
                    selectedColor: AppColors.primary,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    showCheckmark: false,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          
          // Invoice List
          Expanded(
            child: _filteredInvoices.isEmpty 
              ? Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.receipt_long_outlined, size: 64, color: AppColors.textDim.withOpacity(0.3)),
                    const SizedBox(height: 16),
                    Text('No invoices found in $_activeFilter', style: const TextStyle(color: AppColors.textDim)),
                  ],
                ))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _filteredInvoices.length,
                  itemBuilder: (context, index) {
                    final invoice = _filteredInvoices[index];
                    final status = invoice['status']!;
                    Color statusColor = AppColors.success;
                    if (status == 'Pending') statusColor = AppColors.warning;
                    if (status == 'Overdue') statusColor = AppColors.error;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: InkWell(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => InvoiceDetailScreen(data: invoice))),
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: statusColor.withOpacity(0.1)),
                            boxShadow: Theme.of(context).brightness == Brightness.light 
                              ? [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)] : [],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(Icons.receipt_outlined, color: statusColor, size: 22),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(invoice['client']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    Text(invoice['date']!, style: const TextStyle(color: AppColors.textDim, fontSize: 12)),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(invoice['amount']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: statusColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(status.toUpperCase(), style: TextStyle(color: statusColor, fontSize: 9, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}

class InvoiceDetailScreen extends StatelessWidget {
  final Map<String, String> data;
  const InvoiceDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final status = data['status']!;
    Color statusColor = AppColors.success;
    if (status == 'Pending') statusColor = AppColors.warning;
    if (status == 'Overdue') statusColor = AppColors.error;

    return Scaffold(
      appBar: AppBar(title: const Text('Invoice Details')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20)],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: const Icon(Icons.business_center, color: AppColors.primary, size: 36),
                  ),
                  const SizedBox(height: 20),
                  Text(data['client']!, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Invoice #INV-2026-0${data['client']!.length}', style: const TextStyle(color: AppColors.textDim)),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Divider(thickness: 0.5),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Amount Due', style: TextStyle(color: AppColors.textDim, fontSize: 16)),
                      Text(data['amount']!, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _detailRow('Due Date', data['date']!),
                  const SizedBox(height: 16),
                  _detailRow('Status', data['status']!, color: statusColor),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment reminder sent!')));
              },
              child: const Text('Send Reminder'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment link copied to clipboard!')));
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                side: const BorderSide(color: AppColors.primary, width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Share Payment Link', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppColors.textDim)),
        Text(value, style: TextStyle(fontWeight: FontWeight.w600, color: color)),
      ],
    );
  }
}
