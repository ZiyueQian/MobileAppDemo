package com.example.authenticationdemo;

import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;

import retrofit2.Retrofit;

public class HomeActivity extends AppCompatActivity {
    private Retrofit retrofit;
    private RetrofitInterface retrofitInterface;
    private String BASE_URL="http://10.0.2.2:3000";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);

        ActionBar actionBar = getSupportActionBar();
        actionBar.hide();

        LogIn user = MainActivity.myUser;
        View view = getLayoutInflater().inflate(R.layout.activity_home, null);

        String userName = user.getName();
        String userToken = user.getAccessToken();
        TextView nameView = findViewById(R.id.welcome);
        nameView.setText("Welcome, " + userName + "!");
        TextView tokenView = findViewById(R.id.show_token);
        tokenView.setText("Your token is: \n" + userToken);
    }
}