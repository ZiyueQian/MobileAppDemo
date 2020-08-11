//import 'package:retrofit/retrofit.dart';
//import 'package:flutter/material.dart';
//import 'LogIn.dart';
//
//class MainActivity extends AppCompatActivity {
//
//  Retrofit retrofit;
//  RetrofitInterface retrofitInterface;
//  String BASE_URL="http://10.0.2.2:3000";
//  static LogIn myUser;
//
//  @override
//  void onCreate(Bundle savedInstanceState) {
//    super.onCreate(savedInstanceState);
//    setContentView(R.layout.activity_main);
//
//    retrofit = new Retrofit.Builder().
//    baseUrl(BASE_URL).
//    addConverterFactory(GsonConverterFactory.create()).
//    build();
//
//    retrofitInterface = retrofit.create(RetrofitInterface.class);
//
//    findViewById(R.id.logIn).setOnClickListener(new View.OnClickListener() {
//    @Override
//    public void onClick(View view) {
//    handleLogInPage();
//    }
//    });
//
//    findViewById(R.id.signUp).setOnClickListener(new View.OnClickListener() {
//    @Override
//    public void onClick(View view) {
//    handleSignUpPage();
//    }
//    });
//  }
//
//  void handleSignUpPage() {
//    View view = getLayoutInflater().inflate(R.layout.signup_page, null);
//    //AlertDialog.Builder builder = new AlertDialog.Builder(this);
//    //builder.setView(view).show();
//    Button signupBtn = view.findViewById(R.id.signUp);
//
//    final EditText firstNameEdit = view.findViewById(R.id.firstName);
//    final EditText lastNameEdit = view.findViewById(R.id.lastName);
//    final EditText numberEdit = view.findViewById(R.id.phone_number);
//    final EditText passwordEdit = view.findViewById(R.id.password);
//    final EditText confirmPasswordEdit = view.findViewById(R.id.confirmPassword);
//    signupBtn.setOnClickListener(new View.OnClickListener() {
//    @Override
//    public void onClick(View view) {
//    HashMap<String, String> map = new HashMap<>();
//
//    map.put("firstname", firstNameEdit.getText().toString());
//    map.put("lastname", lastNameEdit.getText().toString());
//    map.put("phone_number", numberEdit.getText().toString());
//    map.put("password", passwordEdit.getText().toString());
//    map.put("confirmPassword", confirmPasswordEdit.getText().toString());
//
//    Call<Void> call = retrofitInterface.executeSignup(map);
//
//    call.enqueue(new Callback<Void>() {
//    @Override
//    public void onResponse(Call<Void> call, Response<Void> response) {
//    if (response.code() == 200) {
//    confirmPasswordEdit.onEditorAction(EditorInfo.IME_ACTION_DONE);
//    Toast.makeText(MainActivity.this, "Signed Up Successfully",
//    Toast.LENGTH_LONG).show();
//    }
//    else if (response.code() == 400)
//    Toast.makeText(MainActivity.this, "User Already Exist",
//    Toast.LENGTH_LONG).show();
//    else if (response.code() == 401)
//    Toast.makeText(MainActivity.this, "Password Not Match",
//    Toast.LENGTH_LONG).show();
//    }
//
//    @Override
//    public void onFailure(Call<Void> call, Throwable t) {
//    Toast.makeText(MainActivity.this, t.getMessage(),
//    Toast.LENGTH_LONG).show();
//    }
//    });
//    }
//    });
//
//
//  }
//
//
//
//}
