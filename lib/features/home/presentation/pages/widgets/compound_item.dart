import 'package:chemical_compounds/core/constants/app_strings.dart';
import 'package:chemical_compounds/features/home/data/models/properties_model.dart';
import 'package:chemical_compounds/routes/app_router.dart';
import 'package:chemical_compounds/routes/app_routes.dart';
import 'package:flutter/material.dart';

class CompoundItem extends StatelessWidget {
  final Property compound;

  const CompoundItem({required this.compound, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        appRouter.pushNamed(
          AppRoutes.details,
          pathParameters: <String, String>{
            AppStrings.cid: compound.cid.toString(),
            AppStrings.iupacName: compound.iupacName ?? '',
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8.0),
          color: Color(0xFFEA5B6F),
        ),
        child: ListTile(
          title: Text(
            compound.compoundName ?? '',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 4),
              _buildName(
                title: 'Formula: ',
                description: compound.molecularFormula ?? '',
              ),
              _buildName(
                title: 'Weight: ',
                description: '${compound.molecularWeight} g/mol',
              ),
              // Text('Hazard: ${compound.hazardStatus}'),
            ],
          ),
          trailing: Icon(Icons.chevron_right, size: 30, color: Colors.white70),
        ),
      ),
    );
  }

  Widget _buildName({required String title, required String description}) {
    return Text.rich(
      TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 14),
        children: <InlineSpan>[
          TextSpan(
            text: title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextSpan(text: description),
        ],
      ),
    );
  }
}
