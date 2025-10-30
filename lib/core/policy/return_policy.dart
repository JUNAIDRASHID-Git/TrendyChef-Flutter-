import 'package:flutter/material.dart';

class ReturnPolicyPage extends StatelessWidget {
  const ReturnPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Return & Exchange Policy',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('1. Return & Exchange Period'),
            _sectionText(
                'You may request a return or exchange within 7 days from the date of delivery.'),

            _sectionTitle('2. Eligibility for Return / Exchange'),
            _sectionText(
                '• The item must be unused, unopened, and in its original packaging.\n'
                '• The product must be in the same condition as received.\n'
                '• A purchase receipt or order confirmation is required.\n\n'
                'Note: Perishable items such as butter, whipping cream, syrups, or oils are not eligible for return once opened.'),

            _sectionTitle('3. Non-Returnable Items'),
            _sectionText(
                '• Opened or used food products.\n'
                '• Items improperly stored or handled after delivery.\n'
                '• Discounted or clearance items.\n'
                '• Custom or special-order products.'),

            _sectionTitle('4. Exchange or Store Credit'),
            _sectionText(
                'Once approved, you will receive store credit or can exchange the item for another product of equal or higher value (paying the difference). Cash refunds are not available.'),

            _sectionTitle('5. Return Shipping'),
            _sectionText(
                'Return shipping costs are paid by the customer. We recommend using a courier with tracking. '
                'If the return is due to a wrong or damaged item sent by Trendy Chef, we will cover the shipping costs.'),

            _sectionTitle('6. Return Process'),
            _sectionText(
                '1. Contact support at support@trendychef.sa\n'
                '2. Provide your order number, product details, and reason for return.\n'
                '3. Our team will guide you through the return steps.\n\n'
                'Once received and inspected, we will notify you of the approval and issue store credit or process the exchange.'),

            _sectionTitle('7. Contact Us'),
            _sectionText(
                '📧 support@trendychef.sa\n📞 +966 [your number]\n📍 Trendy Chef, Saudi Arabia'),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _sectionText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          height: 1.5,
          color: Colors.black54,
        ),
      ),
    );
  }
}
