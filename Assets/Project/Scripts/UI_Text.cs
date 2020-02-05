using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class UI_Text : MonoBehaviour
{
    public List<string> Scenes;
    public Text UIText;
    // Update is called once per frame
    
    public void Update_UI(int sceneNumber)
    {
        UIText.text = Scenes[sceneNumber];
    }
}
