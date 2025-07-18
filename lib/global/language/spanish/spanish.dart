import '../../../utils/static_strings/static_strings.dart';

Map<String, String> spanish = {
  ///====================== Initial ========================
  AppStrings.appName: "Estoy en\nel teléfono",
  AppStrings.appTagLine: "Rastrea artículos, \nCalcula, Juntos",
  AppStrings.getStarted: "Comenzar",
  AppStrings.welcome: "Bienvenido",

  ///====================== Auth ========================
  AppStrings.signUp: "Registrarse",
  AppStrings.signIn: "Iniciar sesión",
  AppStrings.adminSignUp: "Registro de Admin",
  AppStrings.or: "O",
  AppStrings.email: "Correo electrónico",
  AppStrings.fullName: "Nombre completo",
  AppStrings.employee: "Empleado",
  AppStrings.admin: "Administrador",
  AppStrings.successful: "Exitoso",

  // New auth validation strings in Spanish
  AppStrings.fullNameRequired: "El nombre completo es requerido",
  AppStrings.fullNameMinLength: "El nombre completo debe tener al menos 2 caracteres",
  AppStrings.emailRequired: "El correo electrónico es requerido",
  AppStrings.enterValidEmail: "Por favor, ingresa un correo electrónico válido",
  AppStrings.passwordRequired: "La contraseña es requerida",
  AppStrings.confirmPasswordRequired: "Confirmar contraseña es requerido",
  AppStrings.passwordsDoNotMatch: "Las contraseñas no coinciden",
  AppStrings.validationError: "¡Error de validación!",
  AppStrings.pleaseFixErrors: "Por favor, corrige los errores en el formulario",
  AppStrings.success: "¡Éxito!",
  AppStrings.accountCreatedSuccessfully: "¡Cuenta creada exitosamente!",
  AppStrings.error: "¡Error!",
  AppStrings.failedToCreateAccount: "Error al crear la cuenta. Por favor, inténtalo de nuevo.",
  AppStrings.warning: "¡Advertencia!",
  AppStrings.pleaseEnterEmail: "Por favor, ingresa el correo electrónico",
  AppStrings.welcome_title: "¡Bienvenido!",
  AppStrings.adminLoginSuccessful: "Inicio de sesión de administrador exitoso",
  AppStrings.userLoginSuccessful: "Inicio de sesión de usuario exitoso",
  AppStrings.invalidCredentials: "¡Credenciales inválidas!",
  AppStrings.enterAdminOrUser: "Por favor, ingresa \"admin\" o \"user\" en el campo de correo",
  AppStrings.info: "Información",
  AppStrings.googleLoginNotImplemented: "Inicio de sesión con Google no implementado aún",
  AppStrings.appleLoginNotImplemented: "Inicio de sesión con Apple no implementado aún",
  AppStrings.creatingAccount: "Creando cuenta...",

  AppStrings.congratulations:
      "¡Felicidades! Tu contraseña ha sido cambiada. Haz clic en continuar para iniciar sesión",
  AppStrings.emailText: 'contacto@dscode...com',
  AppStrings.passwordReset: "Restablecer contraseña",
  AppStrings.enterYourEmailHint: "Introduce tu correo electrónico",
  AppStrings.reEnterPassword: "Vuelve a ingresar la contraseña",
  AppStrings.confirmPasswordHint: "Confirmar contraseña",
  AppStrings.monthlyReport: "Informe mensual",
  AppStrings.updatePassword: "Actualizar contraseña",
  AppStrings.resendEmail: "Reenviar correo",
  AppStrings.setANewPassword: "Establecer una nueva contraseña",
  AppStrings.monthlyGrocerySpending: "Gasto mensual en comestibles",
  AppStrings.totalExpenses: "Gastos totales",
  AppStrings.viewBreakdown: "Ver desglose",
  AppStrings.trackTotalSpent: "Rastrear gasto total",
  AppStrings.totalSpent: "Total gastado",
  AppStrings.budgetLimit: "Límite de presupuesto",
  AppStrings.groceryItems: "Artículos de comestibles",
  AppStrings.underBudget: "Dentro del presupuesto",
  AppStrings.recentPurchases: "Compras recientes",
  AppStrings.createANewPassword:
      "Crea una nueva contraseña. Asegúrate de que sea diferente a las anteriores por seguridad",
  AppStrings.youEmail: "Tu correo electrónico",
  AppStrings.enterYourFullName: "Introduce tu nombre completo",
  AppStrings.enterYourNewPassword: "Introduce tu nueva contraseña",
  AppStrings.confirmYourNewPassword: "Confirma tu nueva contraseña",
  AppStrings.enterYourCurrentPassword: "Introduce tu contraseña actual",
  AppStrings.pleaseEnterYourEmailToReset:
      "Por favor, introduce tu correo electrónico para restablecer la contraseña",
  AppStrings.weSent: "Enviamos un enlace de restablecimiento a ",
  AppStrings.checkYourEmail: "Revisa tu correo electrónico",
  AppStrings.haveNotGotTheMail: "¿No recibiste el correo? ",
  AppStrings.verifyCode: "Verificar código",
  AppStrings.enterYour5Digit: "Introduce el código de 5 dígitos del correo",
  AppStrings.confirm: "Confirmar",
  AppStrings.confirmPassword:
      "Tu contraseña ha sido restablecida exitosamente. Haz clic en confirmar para establecer una nueva contraseña",
  AppStrings.password: "Contraseña",
  AppStrings.currentPassword: "Contraseña actual",
  AppStrings.newPassword: "Nueva contraseña",
  AppStrings.confirmNewPassword: "Confirmar nueva contraseña",
  AppStrings.passwordHint: "********",
  AppStrings.passWordMustBeAtLeast:
      "La contraseña debe contener al menos una mayúscula, una minúscula y un número",
  AppStrings.fieldCantNotBeEmpty: "El campo no puede estar vacío",
  AppStrings.passwordLengthAndContain:
      "La contraseña debe tener al menos 8 caracteres, una mayúscula, una minúscula y un número",
  AppStrings.forgotPassword: "¿Olvidaste la contraseña?",
  AppStrings.doYouHaveAnAccount: "¿Tienes una cuenta?",
  AppStrings.rememberMe: "Recuérdame",
  AppStrings.dontHaveAAccount: "¿No tienes una cuenta? ",

  ///====================== Subscription ========================
  AppStrings.subscribe: "Suscribirse",
  AppStrings.skip: "Omitir",
  AppStrings.getUnlimitedAccess: "Obtén acceso ilimitado a nuestros programas.",
  AppStrings.takeTheFirstStep:
      "Da el primer paso hacia una vida más saludable y feliz.",
  AppStrings.popular: "POPULAR",
  AppStrings.forMoreAccess: "Para más acceso",
  AppStrings.sixtyPointNoneNine: "\$60.99",
  AppStrings.forOneYear: "Por 1 año",
  AppStrings.unlimitedAccess: "Acceso ilimitado",
  AppStrings.viewMonthlyRecord: "Ver registro mensual",
  AppStrings.youWillBe:
      "Se te cobrará \$9.99 (plan mensual) o \$60.99 (plan anual) a través de tu cuenta de iTunes. Puedes cancelar en cualquier momento si no estás satisfecho.",
  AppStrings.appleStorePay: "Pago en Apple Store",
  AppStrings.unlockExclusivefeatures:
      "Desbloquea funciones exclusivas y mejora tu experiencia.",
  AppStrings.completeYourPurchase: "Completa tu compra",
  AppStrings.upgradeNow: "Actualizar ahora",
  AppStrings.paymentMethod: "Método de pago",
  AppStrings.paymentMethodHint: "MasterCard 13345***44",
  AppStrings.payWithApplePayAndGetOffers:
      "Paga con Apple Pay y obtén ofertas y descuentos en tu próxima compra",
  AppStrings.pay: "Pagar",
  AppStrings.payNow: "Pagar ahora",

  ///====================== Home ========================
  AppStrings.yourGroceryExpensesAtAGlance:
      "Tus gastos en comestibles de un vistazo",
  AppStrings.add: "Agregar",
  AppStrings.purchaseHistory: "Historial de compras",
  AppStrings.itemsYouveBought: "Artículos que has comprado",
  AppStrings.viewAll: "Ver todo",

  ///====================== Scanner ========================
  AppStrings.scanner: "Escáner",
  AppStrings.recentScans: "Escaneos recientes",
  AppStrings.edit: "Editar",
  AppStrings.save: "Guardar",
  AppStrings.processed: "Procesado",

  ///====================== Transaction History ========================
  AppStrings.transactionHistory: "Historial de transacciones",
  AppStrings.totalSpending: "Gasto total",
  AppStrings.export: "Exportar",
  AppStrings.download: "Descargar",

  ///====================== Profile ========================
  AppStrings.profile: "Perfil",
  AppStrings.unlockExclusiveFeatures:
      "Desbloquea funciones exclusivas y mejora tu experiencia.",
  AppStrings.manager: "Gerente",
  AppStrings.addedReceipt: "Recibo agregado",
  AppStrings.recently: "Recientemente",
  AppStrings.total: "Total",

  ///====================== Report ========================
  AppStrings.report: "Informe",
  AppStrings.cancel: "Cancelar",
  AppStrings.takeFirstStep: "Da el primer paso",
  AppStrings.monthlyPremiumPlan: "Plan premium mensual",
  AppStrings.yearlyPremiumPlan: "Plan premium anual",
  AppStrings.moreScan: "Más escaneos",
  AppStrings.unlockMonthlyReport: "Desbloquear informe mensual",
  AppStrings.unlimitedScan: "Escaneo ilimitado",
  AppStrings.unlockYearlyReport: "Desbloquear informe anual",
  AppStrings.pricingInfo: "Información de precios",
  AppStrings.freeTrialFor: "Prueba gratis por",
  AppStrings.sevenDays: "7 días",
  AppStrings.fifteenSec: "15 seg",
  AppStrings.thirtySec: "30 seg",
  AppStrings.oneMin: "1 min",
  AppStrings.custom: "Personalizado",
  AppStrings.startCall: "Iniciar llamada",
  AppStrings.caller: "Llamador",
  AppStrings.mom: "Mamá",
  AppStrings.dad: "Papá",
  AppStrings.love: "Amor",
  AppStrings.setUpFakeCall: "Configurar llamada falsa",
  AppStrings.setCustomTime: "Establecer tiempo personalizado",
  AppStrings.minutes: "Minutos",
  AppStrings.seconds: "Segundos",
  AppStrings.selected: "Seleccionado",
  AppStrings.setTime: "Establecer hora",
  AppStrings.pleaseSelectCallerAndTime:
      "Por favor, selecciona llamador y tiempo",
  AppStrings.pleaseSetValidTime: "Por favor, establece un tiempo válido",
  AppStrings.fakeCallWillStartIn: "La llamada falsa comenzará en",
  AppStrings.search: "Buscar",
  AppStrings.bestFriend: "Mejor amigo",
  AppStrings.momWorriedMessage: "¿Dónde estás? Llámame cuando puedas.",
  AppStrings.bestFriendMessage: "¡Hey! ¿Puedes hablar ahora?",
  AppStrings.dadMessage: "¿Cuándo llegarás a casa?",
  AppStrings.loveMessage: "Te extraño, llámame.",
  AppStrings.settings: "Configuraciones",
  AppStrings.chooseYourIconColor: "Elige el color de tu icono",
  AppStrings.chooseYourLanguage: "Elige tu idioma",
  AppStrings.english: "Inglés",
  AppStrings.spanish: "Español",
  AppStrings.ringtone: "Tono de llamada",
  AppStrings.defaultRingtone: "Tono predeterminado",
  AppStrings.quad: "Cuádruple",
  AppStrings.radial: "Radial",
  AppStrings.resetToDefault: "Restablecer a predeterminado",
  AppStrings.saveChanges: "Guardar cambios",
  AppStrings.changesSaved: "Cambios guardados",
  AppStrings.light: "Claro",
  AppStrings.dashboard: "Panel",
  AppStrings.totalSubscribers: "Total de suscriptores",
  AppStrings.manageUsers: "Gestionar usuarios",
  AppStrings.appSettings: "Configuración de la app",
  AppStrings.monthlyUserGrowth: "Crecimiento mensual de usuarios",
  AppStrings.jan: "Ene",
  AppStrings.feb: "Feb",
  AppStrings.mar: "Mar",
  AppStrings.apr: "Abr",
  AppStrings.may: "May",
  AppStrings.jun: "Jun",
  AppStrings.userManagement: "Gestión de usuarios",
  AppStrings.searchUsers: "Buscar usuarios",
  AppStrings.subscriber: "Suscriptor",
  AppStrings.adminEmail: "Correo del administrador",
  AppStrings.profileAndAccount: "Perfil y cuenta",
  AppStrings.updateProfile: "Actualizar perfil",
  AppStrings.changePassword: "Cambiar contraseña",
  AppStrings.appPreference: "Preferencia de la app",
  AppStrings.appConfigurations: "Configuraciones de la app",
  AppStrings.logout: "Cerrar sesión",
  AppStrings.camera: "Cámara",
  AppStrings.upload: "Subir",
  AppStrings.tapCameraToUpload: "Toca la cámara para subir",
  AppStrings.notifications: "Notificaciones",
  AppStrings.controlNotifications: "Controlar notificaciones",
  AppStrings.pushNotifications: "Notificaciones push",
  AppStrings.receivePushNotifications: "Recibir notificaciones push",
  AppStrings.calling: "Llamando",
  AppStrings.remindMe: "Recuérdame",
  AppStrings.message: "Mensaje",
  AppStrings.decline: "Rechazar",
  AppStrings.accept: "Aceptar",
  AppStrings.mute: "Silenciar",
  AppStrings.keyboard: "Teclado",
  AppStrings.speaker: "Altavoz",
  AppStrings.sound: "Sonido",
  AppStrings.addCall: "Agregar llamada",
  AppStrings.video: "Video",
  AppStrings.callers: "Llamadores",
  AppStrings.newContact: "Nuevo contacto",
  AppStrings.done: "Hecho",
  AppStrings.addPhoto: "Agregar foto",
  AppStrings.firstName: "Nombre",
  AppStrings.lastName: "Apellido",
  AppStrings.phoneNumber: "Número de teléfono",
  AppStrings.addVoice: "Agregar voz",
  AppStrings.addTheme: "Agregar tema",
  AppStrings.saveContact: "Guardar contacto",
  AppStrings.forCustom: "Por personalizado",
  AppStrings.pricePerYear: "Precio por año",
  AppStrings.fullLibrary: "Biblioteca completa",
  AppStrings.customCaller: "Llamador personalizado",
  AppStrings.subscriptionNote: "Nota de suscripción",
  AppStrings.passwordResetLinkSent: "Enlace de restablecimiento de contraseña enviado a tu correo",
  AppStrings.failedToSendResetLink: "Error al enviar el enlace de restablecimiento. Por favor, inténtalo de nuevo.",
  AppStrings.sending: "Enviando...",
 
AppStrings.gallery: "Galería",
AppStrings.selectImageSource: "Seleccionar fuente de imagen",
AppStrings.profilePictureUpdated: "Foto de perfil actualizada exitosamente",
AppStrings.failedToPickImage: "Error al seleccionar imagen. Inténtalo de nuevo.",
AppStrings.profileUpdatedSuccessfully: "Perfil actualizado exitosamente",
AppStrings.failedToUpdateProfile: "Error al actualizar perfil. Inténtalo de nuevo.",
AppStrings.currentPasswordRequired: "La contraseña actual es requerida",
AppStrings.newPasswordRequired: "La nueva contraseña es requerida",
AppStrings.newPasswordMustBeDifferent: "La nueva contraseña debe ser diferente a la actual",
AppStrings.passwordChangedSuccessfully: "Contraseña cambiada exitosamente",
AppStrings.failedToChangePassword: "Error al cambiar contraseña. Inténtalo de nuevo.",
AppStrings.updating: "Actualizando...",
AppStrings.changing: "Cambiando...",
// Contact form translations in Spanish
AppStrings.newContact: "Nuevo Contacto",
AppStrings.cancel: "Cancelar",
AppStrings.done: "Listo",
AppStrings.addPhoto: "Agregar Foto",
AppStrings.firstName: "Nombre",
AppStrings.lastName: "Apellido",
AppStrings.phoneNumber: "Número de Teléfono",
AppStrings.message: "Mensaje",
AppStrings.addVoice: "Agregar Voz",
AppStrings.addTheme: "Agregar Tema",
AppStrings.saveContact: "Guardar Contacto",

// Validation translations in Spanish
AppStrings.firstNameRequired: "El nombre es requerido",
AppStrings.firstNameMinLength: "El nombre debe tener al menos 2 caracteres",
AppStrings.lastNameRequired: "El apellido es requerido",
AppStrings.lastNameMinLength: "El apellido debe tener al menos 2 caracteres",
AppStrings.phoneNumberRequired: "El número de teléfono es requerido",
AppStrings.invalidPhoneNumber: "Por favor, ingresa un número de teléfono válido",
AppStrings.messageRequired: "El mensaje es requerido",
AppStrings.messageMinLength: "El mensaje debe tener al menos 10 caracteres",

// Success/Error translations in Spanish
AppStrings.profileImageSelected: "Imagen de perfil seleccionada exitosamente",
AppStrings.voiceFileSelected: "Archivo de voz seleccionado exitosamente",
AppStrings.failedToPickVoiceFile: "Error al seleccionar archivo de voz. Inténtalo de nuevo.",
AppStrings.contactSavedSuccessfully: "Contacto guardado exitosamente",
AppStrings.failedToSaveContact: "Error al guardar contacto. Inténtalo de nuevo.",
AppStrings.contactUpdatedSuccessfully: "Contacto actualizado exitosamente",
AppStrings.failedToUpdateContact: "Error al actualizar contacto. Inténtalo de nuevo.",
AppStrings.contactDeletedSuccessfully: "Contacto eliminado exitosamente",
AppStrings.failedToDeleteContact: "Error al eliminar contacto. Inténtalo de nuevo.",
AppStrings.editContact: "Editar Contacto",
AppStrings.updateContact: "Actualizar Contacto",
AppStrings.saving: "Guardando...",
AppStrings.contacts: "contactos",
AppStrings.saved: "guardados",
AppStrings.noContactsYet: "Aún no hay contactos",
AppStrings.noResultsFound: "No se encontraron resultados",
AppStrings.addFirstContact: "Agrega tu primer contacto",
AppStrings.delete: "Eliminar",
AppStrings.deleteContact: "Eliminar Contacto",
AppStrings.deleteContactConfirmation: "¿Estás seguro de que quieres eliminar a {name}?",
AppStrings.close: "Cerrar",
AppStrings.call: "Llamar",
AppStrings.contactListUpdated: "Lista de contactos actualizada",

AppStrings.contactAddedSuccessfully: "Contacto agregado exitosamente",
AppStrings.failedToOpenNewContactScreen: "Error al abrir nueva pantalla de contacto",
AppStrings.failedToOpenEditScreen: "Error al abrir pantalla de edición",
AppStrings.searchCleared: "Búsqueda borrada",
AppStrings.showingAllContacts: "Mostrando todos los contactos",
AppStrings.noResults: "Sin resultados",
AppStrings.tryDifferentSearchTerm: "Prueba un término de búsqueda diferente",
AppStrings.details: "Detalles",
AppStrings.share: "Compartir",
AppStrings.createContact: "Crear Contacto",
AppStrings.sharing: "Compartiendo",
AppStrings.contactCreatedFromTemplate: "Contacto creado desde plantilla",
AppStrings.failedToCreateContact: "Error al crear contacto",
AppStrings.templateEditedAndSaved: "Plantilla editada y guardada como contacto",
AppStrings.failedToEditTemplate: "Error al editar plantilla",
AppStrings.deleteTemplate: "Eliminar Plantilla",
AppStrings.deleteTemplateConfirmation: "¿Estás seguro de que quieres eliminar la plantilla {name}?",
AppStrings.cannotDeleteDefaultTemplate: "No se pueden eliminar plantillas predeterminadas",
AppStrings.contactDuplicated: "Contacto duplicado exitosamente",
AppStrings.failedToDuplicateContact: "Error al duplicar contacto",

};
