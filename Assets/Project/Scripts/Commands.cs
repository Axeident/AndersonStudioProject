using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Commands : MonoBehaviour
{
    public void StartSimulation()
    {
        SceneManager.LoadScene("GameScene");
    }

    public void MainMenu()
    {
        SceneManager.LoadScene("Start");
    }

    public void QuitSimulation()
    {
        Application.Quit();
    }
}
