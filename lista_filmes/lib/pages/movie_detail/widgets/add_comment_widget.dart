import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_filmes/pages/movie_detail/movie_detail_controller.dart';
import 'package:lista_filmes/service_locator.dart';

class AddCommentWidget extends StatefulWidget {
  const AddCommentWidget({super.key});

  @override
  State<AddCommentWidget> createState() => _AddCommentWidgetState();
}

@override
class _AddCommentWidgetState extends State<AddCommentWidget> {
  final controller = getIt<MovieDetailController>();
  final formKey = GlobalKey<FormState>();
  final commentNode = FocusNode();
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        child: Card(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Form(
                      key: formKey,
                      child: TextFormField(
                        focusNode: commentNode,
                        controller: commentController,
                        textCapitalization: TextCapitalization.sentences,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(300),
                        ],
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return 'Campo obrigatório';
                          }

                          if (v.length < 3) {
                            return 'O minimo é 3 caracteres';
                          }

                          return null;
                        },
                        decoration: const InputDecoration.collapsed(
                            hintText: "Adicione um comentário"),
                        minLines: 2,
                        maxLines: 5,
                      )),
                ),
                TextButton(
                  onPressed: onSubmitted,
                  child: const Text('Enviar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSubmitted() {
    if (!formKey.currentState!.validate()) return;

    controller.postComment(commentController.text).then((value) {
      // Enviar para API
      commentNode.unfocus();
      formKey.currentState!.reset();
    }, onError: (error) => onError(error));
  }

  void onError(error) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Text(error.toString()),
            ));
  }
}
