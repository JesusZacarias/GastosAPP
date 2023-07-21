import 'package:exp_app/models/combined_model.dart';
import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  final CombinedModel cModel;

  const CommentBox({
    super.key,
    required this.cModel,
  });

  @override
  Widget build(BuildContext context) {
    String _text= '';
    _text = cModel.comment;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(
        children: [
          const Icon(
            Icons.sticky_note_2_outlined,
            size: 35.0,
          ),
          const SizedBox(
            width: 15.0,
          ),
          Expanded(
            child: TextFormField(
              initialValue: _text,
              cursorColor: Colors.green,
              keyboardType: TextInputType.text,
              maxLength: 20,
              decoration: InputDecoration(
                counterText: '',
                hintText: 'Agregar Comentario (Opcional)',
                hintStyle: const TextStyle(
                  fontSize: 18.0,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: const BorderSide(
                    color: Colors.green,
                  ),
                ),
              ),
              onChanged: (txt) {
                cModel.comment = txt;
                print(cModel.comment);
              },
            ),
          )
        ],
      ),
    );
  }
}
