using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SphereSpawner : MonoBehaviour
{
    public GameObject spherePrefab;
    public float spawnTime = 1f;
    public float SphereLifeTime = 3f; 
    private float timer;
    void SpawnSphere()
    {
        Vector3 spawnPosition = new(0, 10, 0); 
        GameObject newSphera = Instantiate(spherePrefab, spawnPosition, Quaternion.identity);
        Destroy(newSphera, SphereLifeTime);
    }

    // Update is called once per frame
    void Update()
    {
        timer += Time.deltaTime;

        if (timer >= spawnTime)
        {
            SpawnSphere();
            timer = 0;
        }
    }
}
