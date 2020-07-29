package com.example.authenticationdemo;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import java.util.HashMap;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class MainActivity extends AppCompatActivity {

    private Retrofit retrofit;
    private RetrofitInterface retrofitInterface;
    private String BASE_URL="http://10.0.2.2:3000";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        retrofit = new Retrofit.Builder().
                baseUrl(BASE_URL).
                addConverterFactory(GsonConverterFactory.create()).
                build();

        retrofitInterface = retrofit.create(RetrofitInterface.class);

        findViewById(R.id.logIn).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                handleLogInPage();
            }
        });

        findViewById(R.id.signUp).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                handleSignUpPage();
            }
        });
    }

    private void handleSignUpPage() {
        View view = getLayoutInflater().inflate(R.layout.signup_page, null);
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setView(view).show();
        Button signupBtn = view.findViewById(R.id.signUp);

        final EditText firstNameEdit = view.findViewById(R.id.firstName);
        final EditText lastNameEdit = view.findViewById(R.id.lastName);
        final EditText emailEdit = view.findViewById(R.id.email);
        final EditText passwordEdit = view.findViewById(R.id.password);
        final EditText confirmPasswordEdit = view.findViewById(R.id.confirmPassword);
        signupBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                HashMap<String, String> map = new HashMap<>();

                map.put("firstname", firstNameEdit.getText().toString());
                map.put("lastname", lastNameEdit.getText().toString());
                map.put("email", emailEdit.getText().toString());
                map.put("password", passwordEdit.getText().toString());
                //map.put("confirmPassword", confirmPasswordEdit.getText().toString());

                Call<Void> call = retrofitInterface.executeSignup(map);

                call.enqueue(new Callback<Void>() {
                    @Override
                    public void onResponse(Call<Void> call, Response<Void> response) {
                        if (response.code() == 200)
                            Toast.makeText(MainActivity.this, "Signed Up Successfully",
                                    Toast.LENGTH_LONG).show();
                        else if (response.code() == 400)
                            Toast.makeText(MainActivity.this, "User Already Exist",
                                    Toast.LENGTH_LONG).show();
                        else if (response.code() == 404)
                            Toast.makeText(MainActivity.this, "Password Not Match",
                                    Toast.LENGTH_LONG).show();
                    }

                    @Override
                    public void onFailure(Call<Void> call, Throwable t) {
                        Toast.makeText(MainActivity.this, t.getMessage(),
                                Toast.LENGTH_LONG).show();
                    }
                });
            }
        });


    }

    private void handleLogInPage() {
        View view = getLayoutInflater().inflate(R.layout.login_page, null);
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setView(view).show();
        Button loginBtn = view.findViewById(R.id.logIn);
        final EditText emailEdit = view.findViewById(R.id.email);
        final EditText passwordEdit = view.findViewById(R.id.password);
        loginBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                HashMap<String, String> map = new HashMap<>();

                map.put("email", emailEdit.getText().toString());
                map.put("password", passwordEdit.getText().toString());

                Call<LogIn> call = retrofitInterface.executeLogin(map);

                call.enqueue(new Callback<LogIn>() {
                    @Override
                    public void onResponse(Call<LogIn> call, Response<LogIn> response) {
                        if (response.code() == 200) {
                            LogIn user = response.body();
                            AlertDialog.Builder builder1 = new AlertDialog.Builder(MainActivity.this);
                            builder1.setTitle(user.getName());
                            builder1.setMessage("Welcome!");
                            builder1.show();
                            Toast.makeText(MainActivity.this, "Logging in",
                                    Toast.LENGTH_LONG).show();
                        }
                        else if (response.code() == 404)
                            Toast.makeText(MainActivity.this, "User Doesn't Exist",
                                    Toast.LENGTH_LONG).show();

                        else if (response.code() == 400)
                            Toast.makeText(MainActivity.this, "Wrong Password",
                                    Toast.LENGTH_LONG).show();

                    }

                    @Override
                    public void onFailure(Call<LogIn> call, Throwable t) {
                        //Toast.makeText(MainActivity.this, t.getMessage(),
                                //Toast.LENGTH_LONG).show();
                        Toast.makeText(MainActivity.this, "here",
                                Toast.LENGTH_LONG).show();
                    }
                });
            }
        });


    }
    
    


}