import 'package:chemical_compounds/features/home/data/models/properties_model.dart';
import 'package:flutter/material.dart';

class CompoundItem extends StatelessWidget {
  final Property compound;

  const CompoundItem({required this.compound, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      elevation: 2.0,
      child: ListTile(
        title: Text(
          'compound.commonName',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 4),
            Text('Formula: ${compound.molecularFormula}'),
            Text('Weight: ${compound.molecularWeight} g/mol'),
            // Text('Hazard: ${compound.hazardStatus}'),
          ],
        ),
      ),
    );
  }
}
