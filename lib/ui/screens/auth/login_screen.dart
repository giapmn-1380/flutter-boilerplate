import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/config/route/app_router.dart';
import 'package:flutter_boilerplate/ui/widgets/common/app_text_field.dart';
import 'package:flutter_boilerplate/ui/widgets/common/dialog/alert_dialog.dart';
import 'package:flutter_boilerplate/ui/widgets/common/primary_button.dart';
import 'package:flutter_boilerplate/utils/validators.dart';
import 'package:flutter_boilerplate/view_models/auth/auth_controller.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isSubmitting = useState(false);

    Future<void> submit() async {
      if (!(formKey.currentState?.validate() ?? false)) return;
      isSubmitting.value = true;
      try {
        await ref.read(authControllerProvider.notifier).login(
              email: emailController.text.trim(),
              password: passwordController.text,
            );
        // Đăng nhập thành công -> redirect của router tự chuyển sang MainStack.
      } on Exception {
        if (context.mounted) {
          showAlertDialog(
            context: context,
            title: 'error_occurred'.tr(),
            content: 'login_failed'.tr(),
            positiveActionTitle: 'ok'.tr(),
            positiveActionPressed: () {},
          );
        }
      } finally {
        isSubmitting.value = false;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.flutter_dash,
                    size: 72,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'login'.tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 32),
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
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => submit(),
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: 'login'.tr(),
                    isLoading: isSubmitting.value,
                    onPressed: submit,
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => context.push(AppRoute.register.path),
                    child: Text('no_account_yet'.tr()),
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
