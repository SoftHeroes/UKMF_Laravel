package com.ukmf.ukmf;

import android.graphics.Color;
import android.support.design.widget.TextInputLayout;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

public class MobileVerification extends AppCompatActivity {

    private TextInputLayout tly_MobileNumber;
    private Spinner sp_CountryCode;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.ly_mobileverification);

        tly_MobileNumber = findViewById(R.id.tly_mobileNumber);
        sp_CountryCode   = findViewById(R.id.sp_contrycode);

        ArrayAdapter<CharSequence> CountryCodeAdapter = ArrayAdapter.createFromResource(this,R.array.CountryCode,android.R.layout.simple_spinner_item);
        CountryCodeAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        sp_CountryCode.setAdapter(CountryCodeAdapter);

        sp_CountryCode.setOnItemSelectedListener(new Spinner.OnItemSelectedListener(){
            public void onItemSelected(AdapterView<?> parent, View view, int pos,
                                       long id) {
                ((TextView) view).setTextColor(Color.RED);
            }
            public void onNothingSelected(AdapterView<?> parent) {
            }

        });

    }

    private boolean validateMobileNumber(){
        String InputmobileNumber = tly_MobileNumber.getEditText().getText().toString().trim();

        if(InputmobileNumber.isEmpty()){
            tly_MobileNumber.setError("Mobile Number is Empty.");
            return false;
        }
        if(InputmobileNumber.length() != 10 ){
            tly_MobileNumber.setError("Mobile Number is incorrect.");
            return false;
        }
        else{
            tly_MobileNumber.setError(null);
            return true;
        }

    }

    public void confirmInput(View v){
        if(!validateMobileNumber()){
            return;
        }
        String Msg = "Mobile Number : "+tly_MobileNumber.getEditText().getText().toString().trim();

        Toast.makeText(this,Msg, Toast.LENGTH_SHORT).show();
    }
}
