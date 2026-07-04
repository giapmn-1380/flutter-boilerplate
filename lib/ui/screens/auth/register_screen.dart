import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/ui/widgets/common/app_text_field.dart';
import 'package:flutter_boilerplate/ui/widgets/common/dialog/alert_dialog.dart';
import 'package:flutter_boilerplate/ui/widgets/common/primary_button.dart';
import 'package:flutter_boilerplate/utils/validators.dart';
import 'package:flutter_boilerplate/view_models/auth/auth_controller.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegisterScreen extends HookConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final isSubmitting = useState(false);

    Future<void> submit() async {
      if (!(formKey.currentState?.validate() ?? false)) return;
      isSubmitting.value = true;
      try {
        await ref.read(authControllerProvider.notifier).register(
              email: emailController.text.trim(),
              password: passwordController.text,
            );
        // Đăng ký thành công -> redirect của router tự chuyển sang MainStack.
      } on Exception {
        if (context.mounted) {
          showAlertDialog(
            context: context,
            title: 'error_occurred'.tr(),
            content: 'register_failed'.tr(),
            positiveActionTitle: 'ok'.tr(),
            positiveActionPressed: () {},
          );
        }
      } finally {
        isSubmitting.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('register'.tr())),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextField(
                    label: 'email'.tr(),
                    controller: emailController,
                    validator: Validators.email,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'password'.tr(),
                    controller: passwordController,
                    validator: Validators.password,
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'confirm_password'.tr(),
                    controller: confirmPasswordController,
                    validator: (value) => Validators.confirmPassword(
                      value,
                      passwordController.text,
                    ),
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => submit(),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'register'.tr(),
                    isLoading: isSubmitting.value,
                    onPressed: submit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
